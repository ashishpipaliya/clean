import 'package:flutter/material.dart';
import '../constants/ui_constants.dart';

enum AppButtonStyle { filled, outlined, text }

/// Standard button with consistent styling
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final IconData? icon;
  final double? width;
  final double height;
  final AppButtonStyle buttonStyle;
  final bool dense;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final BorderRadius? borderRadius;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.icon,
    this.width,
    this.height = 48,
    this.buttonStyle = AppButtonStyle.filled,
    this.dense = false,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
  });

  /// Primary filled button
  factory AppButton.filled({
    Key? key,
    required String label,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isDisabled = false,
    IconData? icon,
    double? width,
    double height = 48,
    bool dense = false,
    Color? backgroundColor,
    Color? foregroundColor,
    BorderRadius? borderRadius,
  }) {
    return AppButton(
      key: key,
      label: label,
      onPressed: onPressed,
      isLoading: isLoading,
      isDisabled: isDisabled,
      icon: icon,
      width: width,
      height: height,
      buttonStyle: AppButtonStyle.filled,
      dense: dense,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      borderRadius: borderRadius,
    );
  }

  /// Secondary outlined button
  factory AppButton.outlined({
    Key? key,
    required String label,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isDisabled = false,
    IconData? icon,
    double? width,
    double height = 48,
    bool dense = false,
    Color? foregroundColor,
    BorderRadius? borderRadius,
  }) {
    return AppButton(
      key: key,
      label: label,
      onPressed: onPressed,
      isLoading: isLoading,
      isDisabled: isDisabled,
      icon: icon,
      width: width,
      height: height,
      buttonStyle: AppButtonStyle.outlined,
      dense: dense,
      foregroundColor: foregroundColor,
      borderRadius: borderRadius,
    );
  }

  /// Text button
  factory AppButton.text({
    Key? key,
    required String label,
    VoidCallback? onPressed,
    bool isDisabled = false,
    IconData? icon,
    double? width,
    double height = 48,
    bool dense = false,
    Color? foregroundColor,
    BorderRadius? borderRadius,
  }) {
    return AppButton(
      key: key,
      label: label,
      onPressed: onPressed,
      isDisabled: isDisabled,
      icon: icon,
      width: width,
      height: height,
      buttonStyle: AppButtonStyle.text,
      dense: dense,
      foregroundColor: foregroundColor,
      borderRadius: borderRadius,
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveHeight = dense ? 40.0 : height;
    final isButtonDisabled = isDisabled || isLoading || onPressed == null;

    final content = isLoading
        ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: buttonStyle == AppButtonStyle.filled
                  ? (foregroundColor ?? Theme.of(context).colorScheme.primary)
                  : (foregroundColor ?? Theme.of(context).colorScheme.primary),
            ),
          )
        : icon != null
        ? Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, size: 20), const SizedBox(width: 8), Text(label)])
        : Text(label);

    final hasCustomColors = backgroundColor != null || foregroundColor != null;
    final hasCustomStyle = hasCustomColors || dense || borderRadius != null;
    final effectiveBorderRadius = borderRadius ?? BorderRadius.circular(UIConstants.defaultBorderRadius);

    switch (buttonStyle) {
      case AppButtonStyle.filled:
        ButtonStyle? customStyle;

        if (hasCustomStyle) {
          customStyle = FilledButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            padding: dense ? const EdgeInsets.symmetric(horizontal: 16, vertical: 8) : null,
            shape: RoundedRectangleBorder(borderRadius: effectiveBorderRadius),
          );
        }

        return SizedBox(
          width: width,
          height: effectiveHeight,
          child: FilledButton(onPressed: isButtonDisabled ? null : onPressed, style: customStyle, child: content),
        );

      case AppButtonStyle.outlined:
        ButtonStyle? customStyle;

        if (hasCustomStyle) {
          customStyle = OutlinedButton.styleFrom(
            foregroundColor: foregroundColor,
            padding: dense ? const EdgeInsets.symmetric(horizontal: 16, vertical: 8) : null,
            shape: RoundedRectangleBorder(borderRadius: effectiveBorderRadius),
          );
        }

        return SizedBox(
          width: width,
          height: effectiveHeight,
          child: OutlinedButton(onPressed: isButtonDisabled ? null : onPressed, style: customStyle, child: content),
        );

      case AppButtonStyle.text:
        ButtonStyle? customStyle;

        if (hasCustomStyle) {
          customStyle = TextButton.styleFrom(
            foregroundColor: foregroundColor,
            padding: dense ? const EdgeInsets.symmetric(horizontal: 16, vertical: 8) : null,
            shape: RoundedRectangleBorder(borderRadius: effectiveBorderRadius),
          );
        }

        return SizedBox(
          width: width,
          height: effectiveHeight,
          child: TextButton(onPressed: isButtonDisabled ? null : onPressed, style: customStyle, child: content),
        );
    }
  }
}

/// Icon button with tooltip
class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final Color? color;
  final double size;

  const AppIconButton({super.key, required this.icon, this.onPressed, this.tooltip, this.color, this.size = 24});

  @override
  Widget build(BuildContext context) {
    final button = IconButton(
      icon: Icon(icon, size: size),
      onPressed: onPressed,
      color: color,
    );

    if (tooltip != null) {
      return Tooltip(message: tooltip!, child: button);
    }

    return button;
  }
}

/// Floating action button
class AppFab extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String? label;
  final bool isExtended;

  const AppFab({super.key, required this.icon, this.onPressed, this.label, this.isExtended = false});

  @override
  Widget build(BuildContext context) {
    if (isExtended && label != null) {
      return FloatingActionButton.extended(onPressed: onPressed, icon: Icon(icon), label: Text(label!));
    }

    return FloatingActionButton(onPressed: onPressed, child: Icon(icon));
  }
}
