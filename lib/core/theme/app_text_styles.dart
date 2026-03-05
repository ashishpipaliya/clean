import 'package:flutter/material.dart';

/// Centralized text styles for the app
/// All text styles can be changed globally from here
class AppTextStyles {
  AppTextStyles._();

  // Display styles (largest)
  static const displayLarge = TextStyle(fontSize: 57, fontWeight: FontWeight.w400, letterSpacing: -0.25);

  static const displayMedium = TextStyle(fontSize: 45, fontWeight: FontWeight.w400);

  static const displaySmall = TextStyle(fontSize: 36, fontWeight: FontWeight.w400);

  // Headline styles
  static const headlineLarge = TextStyle(fontSize: 32, fontWeight: FontWeight.w400);

  static const headlineMedium = TextStyle(fontSize: 28, fontWeight: FontWeight.w400);

  static const headlineSmall = TextStyle(fontSize: 24, fontWeight: FontWeight.w400);

  // Title styles
  static const titleLarge = TextStyle(fontSize: 22, fontWeight: FontWeight.w500);

  static const titleMedium = TextStyle(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.15);

  static const titleSmall = TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1);

  // Body styles (most common)
  static const bodyLarge = TextStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5);

  static const bodyMedium = TextStyle(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25);

  static const bodySmall = TextStyle(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4);

  // Label styles (buttons, tabs)
  static const labelLarge = TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1);

  static const labelMedium = TextStyle(fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.5);

  static const labelSmall = TextStyle(fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.5);

  // Custom app-specific styles
  static const button = TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.5);

  static const caption = TextStyle(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4);

  static const overline = TextStyle(fontSize: 10, fontWeight: FontWeight.w500, letterSpacing: 1.5);

  // Input field styles
  static const inputLabel = TextStyle(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4);

  static const inputText = TextStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5);

  static const inputHint = TextStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5);

  static const inputError = TextStyle(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4);

  // Helper method to get TextTheme for theme configuration
  static TextTheme getTextTheme() {
    return const TextTheme(
      displayLarge: displayLarge,
      displayMedium: displayMedium,
      displaySmall: displaySmall,
      headlineLarge: headlineLarge,
      headlineMedium: headlineMedium,
      headlineSmall: headlineSmall,
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      titleSmall: titleSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
      labelLarge: labelLarge,
      labelMedium: labelMedium,
      labelSmall: labelSmall,
    );
  }
}
