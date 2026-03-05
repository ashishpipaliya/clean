import 'package:flutter/material.dart';

enum LoadingStyle {
  centered,
  small,
  linear,
}

/// Loading indicator widget
class AppLoading extends StatelessWidget {
  final String? message;
  final double size;
  final Color? color;
  final LoadingStyle style;
  final double? value;
  final Color? backgroundColor;

  const AppLoading({
    super.key,
    this.message,
    this.size = 40,
    this.color,
    this.style = LoadingStyle.centered,
    this.value,
    this.backgroundColor,
  });

  /// Centered loading indicator with optional message
  factory AppLoading.centered({
    Key? key,
    String? message,
    double size = 40,
  }) {
    return AppLoading(
      key: key,
      message: message,
      size: size,
      style: LoadingStyle.centered,
    );
  }

  /// Small inline loading indicator
  factory AppLoading.small({
    Key? key,
    double size = 20,
    Color? color,
  }) {
    return AppLoading(
      key: key,
      size: size,
      color: color,
      style: LoadingStyle.small,
    );
  }

  /// Linear progress indicator
  factory AppLoading.linear({
    Key? key,
    double? value,
    Color? backgroundColor,
    Color? color,
  }) {
    return AppLoading(
      key: key,
      value: value,
      backgroundColor: backgroundColor,
      color: color,
      style: LoadingStyle.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (style) {
      case LoadingStyle.small:
        return SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: color,
          ),
        );

      case LoadingStyle.linear:
        return LinearProgressIndicator(
          value: value,
          backgroundColor: backgroundColor,
          color: color,
        );

      case LoadingStyle.centered:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: size,
                height: size,
                child: const CircularProgressIndicator(),
              ),
              if (message != null) ...[
                const SizedBox(height: 16),
                Text(
                  message!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ],
          ),
        );
    }
  }
}
