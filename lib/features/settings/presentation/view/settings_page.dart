import 'package:clean/core/constants/ui_constants.dart';
import 'package:clean/core/ui/app_bottom_sheet.dart';
import 'package:clean/core/ui/app_dialog.dart';
import 'package:clean/core/widgets/app_button.dart';
import 'package:clean/features/auth/presentation/view/login_page.dart';
import 'package:clean/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:clean/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return BlocListener<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state.loggedOut) {
          context.go(LoginPage.routeName);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.settings)),
        body: Padding(
          padding: const EdgeInsets.all(UIConstants.screenPaddingHorizontal),
          child: ListView(
            children: [
              const SizedBox(height: 16),
              BlocBuilder<SettingsBloc, SettingsState>(
                builder: (context, state) {
                  return ListTile(
                    leading: const Icon(Icons.brightness_6_outlined),
                    title: Text(l10n.theme),
                    subtitle: Text(_getThemeLabel(state.themeMode, l10n)),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _showThemeBottomSheet(context, state.themeMode),
                  );
                },
              ),
              BlocBuilder<SettingsBloc, SettingsState>(
                builder: (context, state) {
                  return ListTile(
                    leading: const Icon(Icons.language_outlined),
                    title: Text(l10n.appLanguage),
                    subtitle: Text(_getLocaleLabel(state.locale, l10n)),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _showLanguageBottomSheet(context, state.locale),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.logout, color: Theme.of(context).colorScheme.error),
                title: Text(l10n.logout, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                onTap: () => _showLogoutDialog(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getThemeLabel(ThemeMode mode, AppLocalizations l10n) {
    switch (mode) {
      case ThemeMode.light:
        return l10n.light;
      case ThemeMode.dark:
        return l10n.dark;
      case ThemeMode.system:
        return l10n.system;
    }
  }

  String _getLocaleLabel(Locale locale, AppLocalizations l10n) {
    switch (locale.languageCode) {
      case 'en':
        return l10n.english;
      case 'hi':
        return l10n.hindi;
      default:
        return locale.languageCode;
    }
  }

  void _showThemeBottomSheet(BuildContext context, ThemeMode currentMode) {
    final l10n = AppLocalizations.of(context)!;
    
    AppBottomSheet.show(
      context,
      title: l10n.chooseTheme,
      useContentHeight: true,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: ThemeMode.values.map((mode) {
            final isSelected = mode == currentMode;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: InkWell(
                onTap: () {
                  context.read<SettingsBloc>().add(SettingsEvent.changeTheme(mode));
                  Navigator.pop(context);
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _getThemeLabel(mode, l10n),
                          style: TextStyle(
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showLanguageBottomSheet(BuildContext context, Locale currentLocale) {
    final l10n = AppLocalizations.of(context)!;
    final locales = [const Locale('en'), const Locale('hi')];

    AppBottomSheet.show(
      context,
      title: l10n.chooseLanguage,
      useContentHeight: true,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: locales.map((locale) {
            final isSelected = locale == currentLocale;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: InkWell(
                onTap: () {
                  context.read<SettingsBloc>().add(SettingsEvent.changeLocale(locale));
                  Navigator.pop(context);
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _getLocaleLabel(locale, l10n),
                          style: TextStyle(
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    AppDialog.show(
      context,
      title: l10n.logout,
      icon: Icons.logout,
      iconColor: Theme.of(context).colorScheme.error,
      content: Text(l10n.logoutConfirmation),
      actions: [
        AppButton.outlined(onPressed: () => Navigator.pop(context), dense: true, label: l10n.cancel),
        AppButton(
          label: l10n.logout,
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
    context.read<SettingsBloc>().add(const SettingsEvent.logout());
  }
}
