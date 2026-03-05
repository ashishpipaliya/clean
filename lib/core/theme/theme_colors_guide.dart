import 'package:flutter/material.dart';

/// Guide for using theme colors that automatically adapt to light/dark mode
/// 
/// ALWAYS use Theme.of(context).colorScheme to access colors
/// This ensures colors change automatically when theme changes
class ThemeColorsGuide {
  ThemeColorsGuide._();

  /// Example usage in widgets:
  /// 
  /// ```dart
  /// // Background colors
  /// Container(
  ///   color: Theme.of(context).colorScheme.surface, // White in light, dark in dark mode
  /// )
  /// 
  /// // Text colors
  /// Text(
  ///   'Hello',
  ///   style: TextStyle(
  ///     color: Theme.of(context).colorScheme.onSurface, // Black in light, white in dark
  ///   ),
  /// )
  /// 
  /// // Primary button color
  /// Container(
  ///   color: Theme.of(context).colorScheme.primary, // Black in light, white in dark
  /// )
  /// 
  /// // Input field background
  /// Container(
  ///   color: Theme.of(context).colorScheme.surfaceContainerHighest, // Light gray in light, dark gray in dark
  /// )
  /// 
  /// // Border color
  /// Container(
  ///   decoration: BoxDecoration(
  ///     border: Border.all(
  ///       color: Theme.of(context).colorScheme.outline, // Subtle gray border
  ///     ),
  ///   ),
  /// )
  /// 
  /// // Error color
  /// Text(
  ///   'Error message',
  ///   style: TextStyle(
  ///     color: Theme.of(context).colorScheme.error, // Red
  ///   ),
  /// )
  /// 
  /// // Secondary/muted text
  /// Text(
  ///   'Secondary text',
  ///   style: TextStyle(
  ///     color: Theme.of(context).colorScheme.secondary, // Gray
  ///   ),
  /// )
  /// ```

  /// Available ColorScheme properties:
  /// 
  /// PRIMARY COLORS:
  /// - primary: Main brand color (Black in light, White in dark)
  /// - onPrimary: Text/icon color on primary (White in light, Black in dark)
  /// 
  /// SECONDARY COLORS:
  /// - secondary: Secondary brand color (Gray)
  /// - onSecondary: Text/icon color on secondary
  /// 
  /// TERTIARY COLORS:
  /// - tertiary: Tertiary brand color (Darker gray)
  /// - onTertiary: Text/icon color on tertiary
  /// 
  /// SURFACE COLORS:
  /// - surface: Background color (White in light, Almost black in dark)
  /// - onSurface: Text/icon color on surface (Black in light, Off-white in dark)
  /// - surfaceContainerHighest: Elevated surface (Light gray in light, Dark gray in dark)
  /// 
  /// UTILITY COLORS:
  /// - outline: Border color (Subtle gray)
  /// - error: Error state color (Red)
  /// - onError: Text/icon color on error (White)
  /// 
  /// QUICK REFERENCE:
  /// - Background: colorScheme.surface
  /// - Text: colorScheme.onSurface
  /// - Button: colorScheme.primary
  /// - Button text: colorScheme.onPrimary
  /// - Input field: colorScheme.surfaceContainerHighest
  /// - Border: colorScheme.outline
  /// - Muted text: colorScheme.secondary
  /// - Error: colorScheme.error
}

/// Extension for easy access to color scheme
extension ThemeColors on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;
}

/// Usage with extension:
/// ```dart
/// Container(
///   color: context.colors.surface,
///   child: Text(
///     'Hello',
///     style: TextStyle(color: context.colors.onSurface),
///   ),
/// )
/// ```
