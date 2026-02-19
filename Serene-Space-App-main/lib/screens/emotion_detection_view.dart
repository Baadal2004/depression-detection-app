import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image/image.dart' as img;
import '../services/emotion_classifier.dart';
import '../widgets/emotion_display.dart';
import '../utils/emotion_constants.dart';

class EmotionDetectionScreen extends StatefulWidget {
  const EmotionDetectionScreen({super.key});

  @override
  State<EmotionDetectionScreen> createState() => _EmotionDetectionScreenState();
}

class _EmotionDetectionScreenState extends State<EmotionDetectionScreen> with WidgetsBindingObserver {
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
      final XFile file = await _cameraController!.takePicture();
      final bytes = await file.readAsBytes();
      final inputImage = InputImage.fromFilePath(file.path);
      final faces = await _faceDetector.processImage(inputImage);

      if (faces.isNotEmpty) {
        final face = faces.first;
        final boundingBox = face.boundingBox;
        final image = img.decodeImage(bytes);
        if (image != null) {
          final x = boundingBox.left.toInt().clamp(0, image.width - 1);
          final y = boundingBox.top.toInt().clamp(0, image.height - 1);
          final w = boundingBox.width.toInt().clamp(1, image.width - x);
          final h = boundingBox.height.toInt().clamp(1, image.height - y);
          final faceCrop = img.copyCrop(image, x: x, y: y, width: w, height: h);
          final scores = _emotionClassifier.classifyFromImage(faceCrop);

          if (scores.isNotEmpty && mounted) {
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
        backgroundColor: EmotionColors.primaryMid,
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [EmotionColors.accentPink, EmotionColors.accentCyan],
          ).createShader(bounds),
          child: const Text(
            'Emotion AI',
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
            icon: Icon(
              _isFrontCamera ? Icons.camera_front : Icons.camera_rear,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: EmotionColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (_isInitialized && _cameraController != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: EmotionColors.glassBorder,
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: CameraPreview(_cameraController!),
                    ),
                  ),
                )
              else
                const Center(
                  child: CircularProgressIndicator(color: EmotionColors.accentCyan),
                ),

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
