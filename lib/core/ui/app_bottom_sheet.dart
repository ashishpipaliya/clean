import 'package:flutter/material.dart';

class AppBottomSheet {
  AppBottomSheet._();

  /// Show a bottom sheet
  static Future<T?> show<T>(
    BuildContext context, {
    String? title,
    required Widget child,
    List<Widget>? actions,
    double? height,
    bool useContentHeight = false,
    bool isDismissible = true,
    bool enableDrag = true,
    double borderRadius = 20.0,
    bool showDragHandle = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(borderRadius),
        ),
      ),
      builder: (context) => SizedBox(
        width: double.infinity,
        height: useContentHeight ? null : height,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: useContentHeight ? MainAxisSize.min : MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (showDragHandle) _buildDragHandle(),
              if (title != null) ...[
                const SizedBox(height: 16),
                _buildTitle(title),
                const Divider(),
              ],
              if (useContentHeight)
                child
              else
                Expanded(child: child),
              if (actions != null && actions.isNotEmpty) ...[
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: actions
                        .map((action) => Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: action,
                            ))
                        .toList(),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// Show a scrollable bottom sheet
  static Future<T?> showScrollable<T>(
    BuildContext context, {
    String? title,
    required Widget child,
    List<Widget>? actions,
    double initialChildSize = 0.6,
    double minChildSize = 0.3,
    double maxChildSize = 0.9,
    bool isDismissible = true,
    bool enableDrag = true,
    double borderRadius = 20.0,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(borderRadius),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: initialChildSize,
        minChildSize: minChildSize,
        maxChildSize: maxChildSize,
        expand: false,
        builder: (context, scrollController) => SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildDragHandle(),
              if (title != null) ...[
                const SizedBox(height: 16),
                _buildTitle(title),
                const Divider(),
              ],
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: child,
                ),
              ),
              if (actions != null && actions.isNotEmpty) ...[
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: actions
                        .map((action) => Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: action,
                            ))
                        .toList(),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildDragHandle() {
    return Column(
      children: [
        const SizedBox(height: 8),
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  static Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
