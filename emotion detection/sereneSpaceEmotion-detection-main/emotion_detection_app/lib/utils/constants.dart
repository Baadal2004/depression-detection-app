/// Color constants, theme configuration, and app-wide styles
import 'package:flutter/material.dart';

class AppColors {
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

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.primaryDark,
      fontFamily: 'Roboto',
      colorScheme: ColorScheme.dark(
        primary: AppColors.accentPink,
        secondary: AppColors.accentPurple,
        surface: AppColors.primaryMid,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: Colors.white70,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accentPink,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
