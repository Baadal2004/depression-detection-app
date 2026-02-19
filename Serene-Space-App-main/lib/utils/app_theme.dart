import 'package:flutter/material.dart';

class SereneTheme {
  // Primary Pink Palette
  static const Color primaryPink = Color(0xFFF06292); // Pink 300
  static const Color lightPink = Color(0xFFFFF5F8); // Very soft pink white
  static const Color darkPink = Color(0xFFAD1457); // Pink 800 for high contrast text
  static const Color accentPink = Color(0xFFEC407A); // Pink 400
  static const Color softGrey = Color(0xFFD1D1D1);
  
  // Professional White/Grey
  static const Color bgWhite = Color(0xFFFFFFFF);
  static const Color textMain = Color(0xFF4A4A4A);
  static const Color textSecondary = Color(0xFF757575);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryPink,
      scaffoldBackgroundColor: lightPink,
      
      // Typography for Elderly (Larger fonts)
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: darkPink,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w700,
          color: darkPink,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: textMain,
        ),
        bodyLarge: TextStyle(
          fontSize: 18, // Large body text for elderly
          color: textMain,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          color: textSecondary,
          height: 1.4,
        ),
        labelLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryPink,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          elevation: 4,
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: darkPink,
          side: const BorderSide(color: primaryPink, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: softGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: softGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primaryPink, width: 2),
        ),
        labelStyle: const TextStyle(fontSize: 16, color: textSecondary),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),

      // App Bar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: darkPink),
        titleTextStyle: TextStyle(
          color: darkPink,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryPink,
        primary: primaryPink,
        secondary: accentPink,
        surface: Colors.white,
        background: lightPink,
        onPrimary: Colors.white,
        onSurface: textMain,
      ),
    );
  }
}
