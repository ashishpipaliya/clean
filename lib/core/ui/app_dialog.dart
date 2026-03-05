import 'package:flutter/material.dart';

class AppDialog {
  AppDialog._();

  /// Show a dialog
  static Future<T?> show<T>(
    BuildContext context, {
    String? title,
    Widget? content,
    IconData? icon,
    Color? iconColor,
    List<Widget>? actions,
    bool barrierDismissible = true,
    double borderRadius = 16.0,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AlertDialog(
        title: _buildTitle(context, title, icon, iconColor),
        content: content,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        actions: _buildActions(actions),
        actionsPadding: EdgeInsets.zero,
      ),
    );
  }

  static Widget? _buildTitle(
    BuildContext context,
    String? title,
    IconData? icon,
    Color? iconColor,
  ) {
    if (title == null) {
      return null;
    }

    return Row(
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            color: iconColor ?? Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 12),
        ],
        Expanded(child: Text(title)),
      ],
    );
  }

  static List<Widget>? _buildActions(List<Widget>? actions) {
    if (actions == null || actions.isEmpty) {
      return null;
    }

    final hasMultipleActions = actions.length > 2;

    if (hasMultipleActions) {
      return [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: actions
                .asMap()
                .entries
                .map((entry) => Padding(
                      padding: EdgeInsets.only(top: entry.key == 0 ? 0 : 8),
                      child: entry.value,
                    ))
                .toList(),
          ),
        ),
      ];
    }

    return [
      Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: actions
              .asMap()
              .entries
              .map((entry) => Padding(
                    padding: EdgeInsets.only(left: entry.key == 0 ? 0 : 8),
                    child: entry.value,
                  ))
              .toList(),
        ),
      ),
    ];
  }

  /// Show loading dialog
  static void showLoading(
    BuildContext context, {
    String message = 'Loading...',
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(message),
            ],
          ),
        ),
      ),
    );
  }

  /// Show custom dialog
  static Future<T?> showCustom<T>(
    BuildContext context, {
    required Widget child,
    bool barrierDismissible = true,
    double borderRadius = 16.0,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: child,
      ),
    );
  }

  /// Hide dialog
  static void hide(BuildContext context) {
    Navigator.of(context).pop();
  }
}
