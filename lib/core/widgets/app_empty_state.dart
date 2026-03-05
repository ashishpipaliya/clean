import 'package:flutter/material.dart';

enum EmptyStateStyle {
  empty,
  error,
}

/// Empty state widget
class AppEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final EmptyStateStyle style;

  const AppEmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.message,
    this.actionLabel,
    this.onAction,
    this.style = EmptyStateStyle.empty,
  });

  /// Standard empty state
  factory AppEmptyState.empty({
    Key? key,
    required IconData icon,
    required String title,
    String? message,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    return AppEmptyState(
      key: key,
      icon: icon,
      title: title,
      message: message,
      actionLabel: actionLabel,
      onAction: onAction,
      style: EmptyStateStyle.empty,
    );
  }

  /// Error state widget
  factory AppEmptyState.error({
    Key? key,
    required String title,
    String? message,
    String? actionLabel,
    VoidCallback? onRetry,
  }) {
    return AppEmptyState(
      key: key,
      icon: Icons.error_outline,
      title: title,
      message: message,
      actionLabel: actionLabel ?? 'Retry',
      onAction: onRetry,
      style: EmptyStateStyle.error,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 80,
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              const SizedBox(height: 8),
              Text(
                message!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.color
                          ?.withValues(alpha: 0.7),
                    ),
                textAlign: TextAlign.center,
              ),
            ],
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 24),
              FilledButton(
                onPressed: onAction,
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
