import 'package:clean/core/ui/app_bottom_sheet.dart';
import 'package:clean/core/ui/app_dialog.dart';
import 'package:clean/core/ui/app_snackbar.dart';
import 'package:clean/core/widgets/app_button.dart';
import 'package:clean/core/widgets/app_card.dart';
import 'package:clean/core/widgets/app_chip.dart';
import 'package:clean/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class WidgetsShowcasePage extends StatefulWidget {
  static const routeName = '/showcase';

  const WidgetsShowcasePage({super.key});

  @override
  State<WidgetsShowcasePage> createState() => _WidgetsShowcasePageState();
}

class _WidgetsShowcasePageState extends State<WidgetsShowcasePage> {
  bool _isLoading = false;
  bool _chipSelected = false;
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.flutter_dash,
          color: Theme.of(context).colorScheme.primary,
          size: 32,
        ),
        title: const Text('Widgets Showcase'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection('Color Scheme', _buildColorScheme()),
          _buildSection('Buttons', _buildButtons()),
          _buildSection('Text Fields', _buildTextFields()),
          _buildSection('Cards', _buildCards()),
          _buildSection('Chips', _buildChips()),
          _buildSection('Dialogs', _buildDialogs()),
          _buildSection('Bottom Sheets', _buildBottomSheets()),
          _buildSection('Snackbars', _buildSnackbars()),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        child,
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildColorScheme() {
    final colors = Theme.of(context).colorScheme;
    
    return Column(
      children: [
        _buildColorBox('Primary', colors.primary, colors.onPrimary),
        const SizedBox(height: 8),
        _buildColorBox('Secondary', colors.secondary, colors.onSecondary),
        const SizedBox(height: 8),
        _buildColorBox('Tertiary', colors.tertiary, colors.onTertiary),
        const SizedBox(height: 8),
        _buildColorBox('Surface', colors.surface, colors.onSurface),
        const SizedBox(height: 8),
        _buildColorBox('Surface Container', colors.surfaceContainerHighest, colors.onSurface),
        const SizedBox(height: 8),
        _buildColorBox('Error', colors.error, colors.onError),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: colors.outline),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Outline (Border)',
                  style: TextStyle(color: colors.onSurface),
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: colors.outline,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildColorBox(String label, Color backgroundColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'on$label',
            style: TextStyle(color: textColor),
          ),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppButton(label: 'Primary Button', onPressed: () {}, icon: Icons.check),
        const SizedBox(height: 12),
        AppButton(
          label: 'Loading Button',
          isLoading: _isLoading,
          onPressed: () {
            setState(() => _isLoading = true);
            Future.delayed(const Duration(seconds: 2), () {
              if (mounted) setState(() => _isLoading = false);
            });
          },
        ),
        const SizedBox(height: 12),
        AppButton(
          label: 'Destructive',
          onPressed: () {},
          icon: Icons.delete,
          backgroundColor: Colors.red,
        ),
        const SizedBox(height: 12),
        AppButton.outlined(label: 'Outlined', onPressed: () {}, icon: Icons.edit),
      ],
    );
  }

  Widget _buildTextFields() {
    return Column(
      children: [
        const AppTextField(
          hint: 'Enter email',
          prefixIcon: Icons.email,
          style: TextFieldStyle.filled,
        ),
        const SizedBox(height: 12),
        const AppTextField(
          hint: 'Password',
          obscureText: true,
          prefixIcon: Icons.lock_outline,
        ),
        const SizedBox(height: 12),
        AppTextField(
          hint: 'Search...',
          prefixIcon: Icons.search,
          borderRadius: 24,
          controller: _textController,
        ),
      ],
    );
  }

  Widget _buildCards() {
    return Column(
      children: [
        AppCard(
          child: Text('Standard Card', style: Theme.of(context).textTheme.titleMedium),
        ),
        const SizedBox(height: 12),
        AppCard.outlined(
          child: Text('Outlined Card', style: Theme.of(context).textTheme.titleMedium),
        ),
      ],
    );
  }

  Widget _buildChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        const AppChip(label: 'Simple', icon: Icons.label),
        AppChip(label: 'Deletable', onDelete: () {}),
        AppChip.choice(
          label: 'Choice',
          selected: _chipSelected,
          onSelected: (v) => setState(() => _chipSelected = v),
        ),
      ],
    );
  }

  Widget _buildDialogs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppButton.outlined(
          label: 'Info Dialog',
          onPressed: () {
            AppDialog.show(
              context,
              title: 'Information',
              content: const Text('This is an informational message.'),
              icon: Icons.info,
              actions: [
                AppButton.text(
                  label: 'OK',
                  dense: true,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 12),
        AppButton.outlined(
          label: 'Confirmation Dialog',
          onPressed: () {
            AppDialog.show(
              context,
              title: 'Confirm Action',
              content: const Text('Are you sure you want to proceed?'),
              icon: Icons.help_outline,
              actions: [
                AppButton.text(
                  label: 'Cancel',
                  dense: true,
                  onPressed: () => Navigator.pop(context),
                ),
                AppButton(
                  label: 'Confirm',
                  dense: true,
                  onPressed: () {
                    Navigator.pop(context);
                    AppSnackbar.show(context, 'Confirmed!', type: SnackbarType.success);
                  },
                ),
              ],
            );
          },
        ),

        const SizedBox(height: 12),
        AppButton.outlined(
          label: 'Loading Dialog',
          onPressed: () {
            AppDialog.showLoading(
              context
            );

            Future.delayed(Duration(seconds: 3), () {
              if(!mounted)return;
                AppDialog.hide(context);
            },);
          },
        ),
        const SizedBox(height: 12),
        AppButton.outlined(
          label: 'Multiple Actions Dialog',
          onPressed: () {
            AppDialog.show(
              context,
              title: 'Choose Action',
              content: const Text('Select one of the options below.'),
              actions: [
                AppButton.text(
                  label: 'Cancel',
                  dense: true,
                  onPressed: () => Navigator.pop(context),
                ),
                AppButton.outlined(
                  label: 'Maybe',
                  dense: true,
                  onPressed: () => Navigator.pop(context),
                ),
                AppButton(
                  label: 'Yes',
                  dense: true,
                  onPressed: () => Navigator.pop(context),
                ),
                AppButton(
                  label: 'Delete',
                  dense: true,backgroundColor: Colors.red,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildBottomSheets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppButton.outlined(
          label: 'Bottom Sheet with Actions',
          onPressed: () {
            AppBottomSheet.show(
              context,
              title: 'Options',
              useContentHeight: true,
              child: const Padding(
                padding: EdgeInsets.all(24),
                child: Text('This is a bottom sheet with action buttons.'),
              ),
              actions: [
                AppButton.text(
                  label: 'Cancel',
                  onPressed: () => Navigator.pop(context),
                ),
                AppButton(
                  label: 'Save',
                  onPressed: () {
                    Navigator.pop(context);
                    AppSnackbar.show(context, 'Saved!', type: SnackbarType.success);
                  },
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 12),
        AppButton.outlined(
          label: 'Scrollable Bottom Sheet',
          onPressed: () {
            AppBottomSheet.showScrollable(
              context,
              title: 'Scrollable Content',
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: List.generate(
                    20,
                    (i) => ListTile(
                      leading: CircleAvatar(child: Text('${i + 1}')),
                      title: Text('Item ${i + 1}'),
                      subtitle: Text('Description for item ${i + 1}'),
                    ),
                  ),
                ),
              ),
              actions: [
                AppButton.text(
                  label: 'Close',
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 12),
        AppButton.outlined(
          label: 'Simple Bottom Sheet',
          onPressed: () {
            AppBottomSheet.show(
              context,
              useContentHeight: true,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Simple bottom sheet without title or actions'),
                    const SizedBox(height: 16),
                    AppButton(
                      label: 'Close',
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSnackbars() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppButton.outlined(
          label: 'Success Snackbar',
          onPressed: () {
            AppSnackbar.show(context, 'Operation completed successfully!', 
              type: SnackbarType.success);
          },
        ),
        const SizedBox(height: 12),
        AppButton.outlined(
          label: 'Error Snackbar',
          onPressed: () {
            AppSnackbar.show(context, 'An error occurred!', 
              type: SnackbarType.error);
          },
        ),
        const SizedBox(height: 12),
        AppButton.outlined(
          label: 'Warning Snackbar',
          onPressed: () {
            AppSnackbar.show(context, 'Warning: Please check your input!', 
              type: SnackbarType.warning);
          },
        ),
        const SizedBox(height: 12),
        AppButton.outlined(
          label: 'Info Snackbar',
          onPressed: () {
            AppSnackbar.show(context, 'Here is some information', 
              type: SnackbarType.info);
          },
        ),
      ],
    );
  }
}
