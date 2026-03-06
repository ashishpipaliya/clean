part of 'settings_bloc.dart';

@freezed
sealed class SettingsEvent with _$SettingsEvent {
  const factory SettingsEvent.changeTheme(ThemeMode themeMode) = _ChangeTheme;
  const factory SettingsEvent.changeLocale(Locale locale) = _ChangeLocale;
  const factory SettingsEvent.loadSettings() = _LoadSettings;
}
