import 'package:flutter/material.dart';

/// Color constants for light and dark themes
class AppColors {
  // Light Theme Colors
  static const Color lightPrimary = Color(0xFF2196F3); // Blue
  static const Color lightSecondary = Color(0xFF03A9F4); // Light Blue
  static const Color lightBackground = Color(0xFFF5F5F5); // Light Grey
  static const Color lightSurface = Color(0xFFFFFFFF); // White
  static const Color lightError = Color(0xFFD32F2F); // Red
  static const Color lightTextPrimary = Color(0xFF212121); // Dark Grey
  static const Color lightTextSecondary = Color(0xFF757575); // Grey

  // Dark Theme Colors
  static const Color darkPrimary = Color(0xFF1976D2); // Darker Blue
  static const Color darkSecondary = Color(0xFF0288D1); // Darker Light Blue
  static const Color darkBackground = Color(0xFF121212); // Very Dark Grey
  static const Color darkSurface = Color(0xFF1E1E1E); // Dark Grey
  static const Color darkError = Color(0xFFCF6679); // Light Red
  static const Color darkTextPrimary = Color(0xFFFFFFFF); // White
  static const Color darkTextSecondary = Color(0xFFB0B0B0); // Light Grey

  // Accent Colors (used in both themes)
  static const Color accentBlue = Color(0xFF2196F3);
  static const Color accentOrange = Color(0xFFFF9800);
  static const Color accentGreen = Color(0xFF4CAF50);

  // Weather Gradient Colors
  static const List<Color> sunnyGradient = [
    Color(0xFFFFA726),
    Color(0xFFFF7043),
  ];

  static const List<Color> cloudyGradient = [
    Color(0xFF78909C),
    Color(0xFF546E7A),
  ];

  static const List<Color> rainyGradient = [
    Color(0xFF5C6BC0),
    Color(0xFF3F51B5),
  ];

  static const List<Color> clearNightGradient = [
    Color(0xFF283593),
    Color(0xFF1A237E),
  ];
}
