/// TFLite-based emotion classifier service
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class EmotionClassifier {
  static const List<String> emotionLabels = [
    'Angry',
    'Disgusted',
    'Fearful',
    'Happy',
    'Neutral',
    'Sad',
    'Surprised',
  ];

  Interpreter? _interpreter;
  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  /// Load the TFLite model
  Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/model.tflite');
      _isLoaded = true;
      print('Emotion model loaded successfully');
    } catch (e) {
      print('Error loading model: $e');
      _isLoaded = false;
    }
  }

  /// Classify emotion from grayscale face image bytes
  /// Returns a map of emotion -> confidence score
  Map<String, double> classify(Uint8List imageBytes, int width, int height) {
    if (!_isLoaded || _interpreter == null) {
      return {};
    }

    try {
      // Decode and preprocess the image
      final image = img.decodeImage(imageBytes);
      if (image == null) return {};

      // Resize to 48x48 as expected by the model
      final resized = img.copyResize(image, width: 48, height: 48);
      
      // Convert to grayscale and normalize
      final input = _preprocessImage(resized);

      // Output shape: [1, 7]
      final output = List.filled(7, 0.0).reshape([1, 7]);

      // Run inference
      _interpreter!.run(input, output);

      // Convert output to emotion map
      final scores = (output[0] as List<double>);
      final result = <String, double>{};
      
      for (int i = 0; i < emotionLabels.length; i++) {
        result[emotionLabels[i]] = scores[i];
      }

      return result;
    } catch (e) {
      print('Error during classification: $e');
      return {};
    }
  }

  /// Classify emotion from a face crop (img.Image)
  Map<String, double> classifyFromImage(img.Image faceImage) {
    if (!_isLoaded || _interpreter == null) {
      return {};
    }

    try {
      // Convert to grayscale
      final grayscale = img.grayscale(faceImage);
      
      // Resize to 48x48
      final resized = img.copyResize(grayscale, width: 48, height: 48);
      
      // Preprocess
      final input = _preprocessImage(resized);

      // Output shape: [1, 7]
      final output = List.filled(7, 0.0).reshape([1, 7]);

      // Run inference
      _interpreter!.run(input, output);

      // Convert output to emotion map
      final scores = (output[0] as List<double>);
      final result = <String, double>{};
      
      for (int i = 0; i < emotionLabels.length; i++) {
        result[emotionLabels[i]] = scores[i];
      }

      return result;
    } catch (e) {
      print('Error during classification: $e');
      return {};
    }
  }

  /// Preprocess image to model input format [1, 48, 48, 1]
  List<List<List<List<double>>>> _preprocessImage(img.Image image) {
    final input = List.generate(
      1,
      (_) => List.generate(
        48,
        (y) => List.generate(
          48,
          (x) {
            final pixel = image.getPixel(x, y);
            // Get grayscale value and normalize to [0, 1]
            final gray = img.getLuminance(pixel) / 255.0;
            return [gray];
          },
        ),
      ),
    );
    return input;
  }

  /// Dispose resources
  void dispose() {
    _interpreter?.close();
    _interpreter = null;
    _isLoaded = false;
  }
}
