import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/ui_constants.dart';

/// Text field style enum
enum TextFieldStyle {
  outlined,
  filled,
}

enum TextFieldType {
  standard,
  area,
}

/// Standard text field with consistent styling
class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? errorText;
  final String? helperText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final int? maxLength;
  final bool enabled;
  final bool readOnly;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final TextCapitalization textCapitalization;
  final TextFieldStyle style;
  final double? borderRadius;
  final TextFieldType type;
  final int minLines;

  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.errorText,
    this.helperText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.maxLines = 1,
    this.maxLength,
    this.enabled = true,
    this.readOnly = false,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.validator,
    this.inputFormatters,
    this.focusNode,
    this.textCapitalization = TextCapitalization.none,
    this.style = TextFieldStyle.outlined,
    this.borderRadius,
    this.type = TextFieldType.standard,
    this.minLines = 1,
  });

  /// Standard text field (default)
  factory AppTextField.standard({
    Key? key,
    TextEditingController? controller,
    String? label,
    String? hint,
    String? errorText,
    String? helperText,
    IconData? prefixIcon,
    Widget? suffixIcon,
    bool obscureText = false,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    int? maxLength,
    bool enabled = true,
    bool readOnly = false,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    VoidCallback? onTap,
    FormFieldValidator<String>? validator,
    List<TextInputFormatter>? inputFormatters,
    FocusNode? focusNode,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextFieldStyle style = TextFieldStyle.outlined,
    double? borderRadius,
  }) {
    return AppTextField(
      key: key,
      controller: controller,
      label: label,
      hint: hint,
      errorText: errorText,
      helperText: helperText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      maxLength: maxLength,
      enabled: enabled,
      readOnly: readOnly,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onTap: onTap,
      validator: validator,
      inputFormatters: inputFormatters,
      focusNode: focusNode,
      textCapitalization: textCapitalization,
      style: style,
      borderRadius: borderRadius,
      type: TextFieldType.standard,
    );
  }

  /// Multiline text field
  factory AppTextField.area({
    Key? key,
    TextEditingController? controller,
    String? label,
    String? hint,
    String? errorText,
    int minLines = 3,
    int maxLines = 6,
    int? maxLength,
    ValueChanged<String>? onChanged,
    FormFieldValidator<String>? validator,
    TextFieldStyle style = TextFieldStyle.outlined,
  }) {
    return AppTextField(
      key: key,
      controller: controller,
      label: label,
      hint: hint,
      errorText: errorText,
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength,
      onChanged: onChanged,
      validator: validator,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      style: style,
      type: TextFieldType.area,
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasLabel = label != null && label!.isNotEmpty;
    final effectiveBorderRadius = borderRadius ?? UIConstants.defaultBorderRadius;

    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: hasLabel ? label : null,
        hintText: hint,
        errorText: errorText,
        helperText: helperText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon,
        border: style == TextFieldStyle.outlined
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(effectiveBorderRadius),
              )
            : style == TextFieldStyle.filled
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(effectiveBorderRadius),
                    borderSide: BorderSide.none,
                  )
                : null,
        filled: style == TextFieldStyle.filled || !enabled,
        fillColor: style == TextFieldStyle.filled
            ? Theme.of(context).colorScheme.surfaceContainerHighest
            : null,
        floatingLabelBehavior: hasLabel
            ? FloatingLabelBehavior.auto
            : FloatingLabelBehavior.never,
        contentPadding: borderRadius != null
            ? const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
            : null,
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      minLines: type == TextFieldType.area ? minLines : null,
      maxLines: maxLines,
      maxLength: maxLength,
      enabled: enabled,
      readOnly: readOnly,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      onTap: onTap,
      validator: validator,
      inputFormatters: inputFormatters,
      textCapitalization: textCapitalization,
    );
  }
}
