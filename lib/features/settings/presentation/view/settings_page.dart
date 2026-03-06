import 'package:clean/core/constants/ui_constants.dart';
import 'package:clean/core/di/injection.dart';
import 'package:clean/core/ui/app_bottom_sheet.dart';
import 'package:clean/core/ui/app_dialog.dart';
import 'package:clean/core/widgets/app_button.dart';
import 'package:clean/features/auth/domain/repository/auth_repository.dart';
import 'package:clean/features/auth/presentation/view/login_page.dart';
import 'package:clean/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(UIConstants.screenPaddingHorizontal),
        child: ListView(
          children: [
            const SizedBox(height: 16),
            Text('Appearance', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return ListTile(
                  leading: const Icon(Icons.brightness_6_outlined),
                  title: const Text('Theme'),
                  subtitle: Text(_getThemeLabel(state.themeMode)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showThemeBottomSheet(context, state.themeMode),
                );
              },
            ),
            const SizedBox(height: 16),
            Text('Language', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return ListTile(
                  leading: const Icon(Icons.language_outlined),
                  title: const Text('App Language'),
                  subtitle: Text(_getLocaleLabel(state.locale)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showLanguageBottomSheet(context, state.locale),
                );
              },
            ),
            const SizedBox(height: 16),
            Text('Account', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ListTile(
              leading: Icon(Icons.logout, color: Theme.of(context).colorScheme.error),
              title: Text('Logout', style: TextStyle(color: Theme.of(context).colorScheme.error)),
              onTap: () => _showLogoutDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  String _getThemeLabel(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }

  String _getLocaleLabel(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'hi':
        return 'हिन्दी (Hindi)';
      default:
        return locale.languageCode;
    }
  }

  void _showThemeBottomSheet(BuildContext context, ThemeMode currentMode) {
    AppBottomSheet.show(
      context,
      title: 'Choose Theme',
      useContentHeight: true,
      child: RadioGroup<ThemeMode>(
        groupValue: currentMode,
        onChanged: (value) {
          if (value != null) {
            context.read<SettingsBloc>().add(SettingsEvent.changeTheme(value));
            Navigator.pop(context);
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: ThemeMode.values.map((mode) {
            final isSelected = mode == currentMode;
            return ListTile(
              leading: Radio<ThemeMode>(value: mode),
              title: Text(_getThemeLabel(mode)),
              selected: isSelected,
              onTap: () {
                context.read<SettingsBloc>().add(SettingsEvent.changeTheme(mode));
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showLanguageBottomSheet(BuildContext context, Locale currentLocale) {
    final locales = [const Locale('en'), const Locale('hi')];

    AppBottomSheet.show(
      context,
      title: 'Choose Language',
      useContentHeight: true,
      child: RadioGroup<Locale>(
        groupValue: currentLocale,
        onChanged: (value) {
          if (value != null) {
            context.read<SettingsBloc>().add(SettingsEvent.changeLocale(value));
            Navigator.pop(context);
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: locales.map((locale) {
            final isSelected = locale == currentLocale;
            return ListTile(
              leading: Radio<Locale>(value: locale),
              title: Text(_getLocaleLabel(locale)),
              selected: isSelected,
              onTap: () {
                context.read<SettingsBloc>().add(SettingsEvent.changeLocale(locale));
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    AppDialog.show(
      context,
      title: 'Logout',
      icon: Icons.logout,
      iconColor: Theme.of(context).colorScheme.error,
      content: const Text('Are you sure you want to logout?'),
      actions: [
        AppButton.outlined(onPressed: () => Navigator.pop(context), dense: true, label: 'Cancel'),
        AppButton(
          label: 'Logout',
          dense: true,
          onPressed: () async {
            Navigator.pop(context);
            await _handleLogout(context);
          },
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      ],
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    final authRepository = getIt<AuthRepository>();
    await authRepository.clearTokens();
    if (context.mounted) {
      context.go(LoginPage.routeName);
    }
  }
}
