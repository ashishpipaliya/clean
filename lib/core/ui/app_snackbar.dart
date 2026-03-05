import 'package:flutter/material.dart';

class AppSnackbar {
  AppSnackbar._();

  /// Show a snackbar with optional type
  static void show(
    BuildContext context,
    String message, {
    SnackbarType? type,
    Duration? duration,
    String? actionLabel,
    VoidCallback? onActionPressed,
    Color? backgroundColor,
    Color? textColor,
    IconData? icon,
    Color? iconColor,
  }) {
    final theme = Theme.of(context);
    final effectiveType = type;
    final effectiveBackgroundColor = backgroundColor ?? effectiveType?.color ?? theme.colorScheme.surfaceContainerHighest;
    final effectiveIcon = icon ?? effectiveType?.icon;
    final effectiveDuration = duration ?? effectiveType?.defaultDuration ?? const Duration(seconds: 3);
    final effectiveTextColor = textColor ?? (effectiveType != null ? Colors.white : theme.colorScheme.onSurface);
    final effectiveIconColor = iconColor ?? effectiveTextColor;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              if (effectiveIcon != null) ...[
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: effectiveTextColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    effectiveIcon,
                    color: effectiveIconColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    color: effectiveTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: effectiveBackgroundColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          elevation: 4,
          duration: effectiveDuration,
          action: actionLabel != null
              ? SnackBarAction(
                  label: actionLabel,
                  textColor: effectiveTextColor,
                  onPressed: onActionPressed ?? () => hide(context),
                )
              : null,
        ),
      );
  }

  /// Hide current snackbar
  static void hide(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}

/// Enhanced enum for snackbar types with properties
enum SnackbarType {
  success(
    color: Color(0xFF10B981),
    icon: Icons.check_circle_rounded,
    defaultDuration: Duration(seconds: 3),
  ),
  error(
    color: Color(0xFFEF4444),
    icon: Icons.error_rounded,
    defaultDuration: Duration(seconds: 4),
  ),
  warning(
    color: Color(0xFFF59E0B),
    icon: Icons.warning_rounded,
    defaultDuration: Duration(seconds: 3),
  ),
  info(
    color: Color(0xFF3B82F6),
    icon: Icons.info_rounded,
    defaultDuration: Duration(seconds: 3),
  );

  final Color color;
  final IconData icon;
  final Duration defaultDuration;

  const SnackbarType({
    required this.color,
    required this.icon,
    required this.defaultDuration,
  });
}
