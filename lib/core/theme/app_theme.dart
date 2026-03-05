import 'package:flutter/material.dart';
import 'app_text_styles.dart';

class AppTheme {
  // Light Theme - Clean black and white like shadcn
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF000000), 
          onPrimary: Color(0xFFFFFFFF),
          secondary: Color(0xFF71717A),
          onSecondary: Color(0xFFFFFFFF),
          tertiary: Color(0xFF52525B),
          onTertiary: Color(0xFFFFFFFF),
          surface: Color(0xFFFFFFFF),
          onSurface: Color(0xFF000000),
          surfaceContainerHighest: Color(0xFFF4F4F5),
          outline: Color(0xFFE4E4E7),
          error: Color(0xFFEF4444),
          onError: Color(0xFFFFFFFF),
        ),
        textTheme: AppTextStyles.getTextTheme(),
      );

  // Dark Theme - Clean dark like shadcn
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFFFFFF), // White
          onPrimary: Color(0xFF000000), // Black
          secondary: Color(0xFFA1A1AA), // Neutral gray
          onSecondary: Color(0xFF000000),
          tertiary: Color(0xFFD4D4D8),
          onTertiary: Color(0xFF000000),
          surface: Color(0xFF09090B), // Almost black
          onSurface: Color(0xFFFAFAFA), // Off-white
          surfaceContainerHighest: Color(0xFF27272A), // Dark gray for inputs
          outline: Color(0xFF3F3F46), // Border color
          error: Color(0xFFEF4444),
          onError: Color(0xFFFFFFFF),
        ),
        textTheme: AppTextStyles.getTextTheme(),
      );

  // Darker Theme - Pure black for AMOLED screens
  static ThemeData get darker => ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFFFFFF),
          onPrimary: Color(0xFF000000), // Black
          secondary: Color(0xFF9CA3AF), // Lighter gray for better contrast
          onSecondary: Color(0xFF000000),
          tertiary: Color(0xFFD1D5DB),
          onTertiary: Color(0xFF000000),
          surface: Color(0xFF000000), // Pure black
          onSurface: Color(0xFFFFFFFF), // Pure white
          surfaceContainerHighest: Color(0xFF1C1C1C), // Very dark gray for inputs
          outline: Color(0xFF2D2D2D), // Dark border
          error: Color(0xFFEF4444),
          onError: Color(0xFFFFFFFF),
        ),
        textTheme: AppTextStyles.getTextTheme(),
      );
}
