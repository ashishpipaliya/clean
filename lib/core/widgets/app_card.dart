import 'package:flutter/material.dart';

enum CardStyle {
  filled,
  outlined,
}

/// Standard card with consistent styling
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final Color? color;
  final double elevation;
  final double borderRadius;
  final CardStyle style;
  final Color? borderColor;
  final double borderWidth;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.color,
    this.elevation = 1,
    this.borderRadius = 12,
    this.style = CardStyle.filled,
    this.borderColor,
    this.borderWidth = 1,
  });

  /// Filled card with elevation
  factory AppCard.filled({
    Key? key,
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    VoidCallback? onTap,
    Color? color,
    double elevation = 1,
    double borderRadius = 12,
  }) {
    return AppCard(
      key: key,
      style: CardStyle.filled,
      elevation: elevation,
      color: color,
      padding: padding,
      margin: margin,
      onTap: onTap,
      borderRadius: borderRadius,
      child: child,
    );
  }

  /// Outlined card with border
  factory AppCard.outlined({
    Key? key,
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    VoidCallback? onTap,
    Color? borderColor,
    double borderWidth = 1,
    double borderRadius = 12,
  }) {
    return AppCard(
      key: key,
      style: CardStyle.outlined,
      borderColor: borderColor,
      borderWidth: borderWidth,
      padding: padding,
      margin: margin,
      onTap: onTap,
      borderRadius: borderRadius,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget card;

    if (style == CardStyle.outlined) {
      card = Container(
        margin: margin,
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor ?? Theme.of(context).dividerColor,
            width: borderWidth,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16),
          child: child,
        ),
      );
    } else {
      card = Card(
        elevation: elevation,
        color: color,
        margin: margin,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16),
          child: child,
        ),
      );
    }

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: card,
      );
    }

    return card;
  }
}
