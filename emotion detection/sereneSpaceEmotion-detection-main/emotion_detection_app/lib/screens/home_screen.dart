/// Main home screen with camera view and real-time emotion detection
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image/image.dart' as img;
import '../services/emotion_classifier.dart';
import '../widgets/emotion_display.dart';
import '../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  CameraController? _cameraController;
  List<CameraDescription> _cameras = [];
  bool _isInitialized = false;
  bool _isProcessing = false;
  bool _isFrontCamera = true;

  final EmotionClassifier _emotionClassifier = EmotionClassifier();
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: false,
      enableClassification: false,
      performanceMode: FaceDetectorMode.fast,
    ),
  );

  String? _currentEmotion;
  Map<String, double> _confidenceScores = {};
  Timer? _processingTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeApp();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _processingTimer?.cancel();
    _cameraController?.dispose();
    _faceDetector.close();
    _emotionClassifier.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      _cameraController?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    }
  }

  Future<void> _initializeApp() async {
    // Request camera permission
    final status = await Permission.camera.request();
    if (status.isGranted) {
      await _emotionClassifier.loadModel();
      await _initializeCamera();
    } else {
      _showPermissionDeniedDialog();
    }
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras.isEmpty) return;

    final cameraIndex = _isFrontCamera
        ? _cameras.indexWhere((c) => c.lensDirection == CameraLensDirection.front)
        : _cameras.indexWhere((c) => c.lensDirection == CameraLensDirection.back);

    final camera = _cameras[cameraIndex >= 0 ? cameraIndex : 0];

    _cameraController = CameraController(
      camera,
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );

    try {
      await _cameraController!.initialize();
      
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });

        // Start periodic frame processing
        _startProcessing();
      }
    } catch (e) {
      debugPrint('Error initializing camera: $e');
    }
  }

  void _startProcessing() {
    _processingTimer?.cancel();
    _processingTimer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      if (!_isProcessing && mounted && _cameraController != null) {
        _processFrame();
      }
    });
  }

  Future<void> _processFrame() async {
    if (_isProcessing || 
        _cameraController == null || 
        !_cameraController!.value.isInitialized ||
        !_emotionClassifier.isLoaded) {
      return;
    }

    _isProcessing = true;

    try {
      // Capture image
      final XFile file = await _cameraController!.takePicture();
      final bytes = await file.readAsBytes();

      // Detect faces using ML Kit
      final inputImage = InputImage.fromFilePath(file.path);
      final faces = await _faceDetector.processImage(inputImage);

      if (faces.isNotEmpty) {
        // Get first face
        final face = faces.first;
        final boundingBox = face.boundingBox;

        // Decode and crop the face from the image
        final image = img.decodeImage(bytes);
        if (image != null) {
          // Ensure bounding box is within image bounds
          final x = boundingBox.left.toInt().clamp(0, image.width - 1);
          final y = boundingBox.top.toInt().clamp(0, image.height - 1);
          final w = boundingBox.width.toInt().clamp(1, image.width - x);
          final h = boundingBox.height.toInt().clamp(1, image.height - y);

          // Crop face
          final faceCrop = img.copyCrop(image, x: x, y: y, width: w, height: h);

          // Classify emotion
          final scores = _emotionClassifier.classifyFromImage(faceCrop);

          if (scores.isNotEmpty && mounted) {
            // Find the emotion with highest confidence
            final topEmotion = scores.entries
                .reduce((a, b) => a.value > b.value ? a : b);

            setState(() {
              _currentEmotion = topEmotion.key;
              _confidenceScores = scores;
            });
          }
        }
      } else {
        if (mounted) {
          setState(() {
            _currentEmotion = null;
            _confidenceScores = {};
          });
        }
      }
    } catch (e) {
      debugPrint('Error processing frame: $e');
    } finally {
      _isProcessing = false;
    }
  }

  void _toggleCamera() async {
    setState(() {
      _isFrontCamera = !_isFrontCamera;
      _isInitialized = false;
    });
    await _cameraController?.dispose();
    await _initializeCamera();
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.primaryMid,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Camera Permission Required',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Please grant camera permission to use emotion detection.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.accentPink, AppColors.accentCyan],
          ).createShader(bounds),
          child: const Text(
            'EmotionAI',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: _isInitialized ? _toggleCamera : null,
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                _isFrontCamera ? Icons.camera_front : Icons.camera_rear,
                key: ValueKey(_isFrontCamera),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Camera preview
              if (_isInitialized && _cameraController != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: AppColors.glassBorder,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accentPurple.withAlpha(50),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: CameraPreview(_cameraController!),
                    ),
                  ),
                )
              else
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: AppColors.accentCyan,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Initializing Camera...',
                        style: TextStyle(
                          color: Colors.white.withAlpha(180),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),

              // Emotion display overlay (bottom)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: EmotionDisplay(
                  emotion: _currentEmotion,
                  confidenceScores: _confidenceScores,
                  isDetecting: _isProcessing,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
