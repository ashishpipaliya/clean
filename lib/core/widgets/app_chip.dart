import 'package:flutter/material.dart';

enum ChipStyle {
  standard,
  choice,
  filter,
}

/// Standard chip with consistent styling
class AppChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final Color? backgroundColor;
  final Color? textColor;
  final ChipStyle style;
  final bool selected;
  final ValueChanged<bool>? onSelected;

  const AppChip({
    super.key,
    required this.label,
    this.icon,
    this.onTap,
    this.onDelete,
    this.backgroundColor,
    this.textColor,
    this.style = ChipStyle.standard,
    this.selected = false,
    this.onSelected,
  });

  /// Standard chip (default)
  factory AppChip.standard({
    Key? key,
    required String label,
    IconData? icon,
    VoidCallback? onTap,
    VoidCallback? onDelete,
    Color? backgroundColor,
    Color? textColor,
  }) {
    return AppChip(
      key: key,
      label: label,
      icon: icon,
      onTap: onTap,
      onDelete: onDelete,
      backgroundColor: backgroundColor,
      textColor: textColor,
      style: ChipStyle.standard,
    );
  }

  /// Choice chip for selection
  factory AppChip.choice({
    Key? key,
    required String label,
    required bool selected,
    ValueChanged<bool>? onSelected,
    IconData? icon,
  }) {
    return AppChip(
      key: key,
      label: label,
      icon: icon,
      selected: selected,
      onSelected: onSelected,
      style: ChipStyle.choice,
    );
  }

  /// Filter chip
  factory AppChip.filter({
    Key? key,
    required String label,
    required bool selected,
    ValueChanged<bool>? onSelected,
    IconData? icon,
  }) {
    return AppChip(
      key: key,
      label: label,
      icon: icon,
      selected: selected,
      onSelected: onSelected,
      style: ChipStyle.filter,
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (style) {
      case ChipStyle.choice:
        return ChoiceChip(
          label: Text(label),
          avatar: icon != null ? Icon(icon, size: 18) : null,
          selected: selected,
          onSelected: onSelected,
        );

      case ChipStyle.filter:
        return FilterChip(
          label: Text(label),
          avatar: icon != null ? Icon(icon, size: 18) : null,
          selected: selected,
          onSelected: onSelected,
        );

      case ChipStyle.standard:
        if (onTap != null) {
          return ActionChip(
            label: Text(label),
            avatar: icon != null ? Icon(icon, size: 18) : null,
            onPressed: onTap,
            backgroundColor: backgroundColor,
            labelStyle: textColor != null ? TextStyle(color: textColor) : null,
          );
        }

        return Chip(
          label: Text(label),
          avatar: icon != null ? Icon(icon, size: 18) : null,
          backgroundColor: backgroundColor,
          labelStyle: textColor != null ? TextStyle(color: textColor) : null,
          deleteIcon: onDelete != null ? const Icon(Icons.close, size: 18) : null,
          onDeleted: onDelete,
        );
    }
  }
}
