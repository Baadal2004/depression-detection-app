import 'package:flutter/material.dart';

class EmotionColors {
  // Primary gradient colors - Deep purple to electric blue
  static const Color primaryDark = Color(0xFF1A1A2E);
  static const Color primaryMid = Color(0xFF16213E);
  static const Color primaryLight = Color(0xFF0F3460);
  
  // Accent colors
  static const Color accentPink = Color(0xFFE94560);
  static const Color accentPurple = Color(0xFF9B5DE5);
  static const Color accentCyan = Color(0xFF00F5D4);
  static const Color accentBlue = Color(0xFF00BBF9);
  
  // Emotion colors
  static const Map<String, Color> emotionColors = {
    'Angry': Color(0xFFE63946),
    'Disgusted': Color(0xFF8338EC),
    'Fearful': Color(0xFF3A0CA3),
    'Happy': Color(0xFFFFD60A),
    'Neutral': Color(0xFF6C757D),
    'Sad': Color(0xFF4361EE),
    'Surprised': Color(0xFFFF006E),
  };
  
  // Emotion emojis
  static const Map<String, String> emotionEmojis = {
    'Angry': '😠',
    'Disgusted': '🤢',
    'Fearful': '😨',
    'Happy': '😊',
    'Neutral': '😐',
    'Sad': '😢',
    'Surprised': '😲',
  };
  
  // Glassmorphism
  static const Color glassWhite = Color(0x20FFFFFF);
  static const Color glassBorder = Color(0x40FFFFFF);
  
  // Gradient
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryDark, primaryMid, primaryLight],
  );
  
  static LinearGradient emotionGradient(String emotion) {
    final color = emotionColors[emotion] ?? accentPurple;
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        color.withAlpha(200),
        color.withAlpha(100),
      ],
    );
  }
}
