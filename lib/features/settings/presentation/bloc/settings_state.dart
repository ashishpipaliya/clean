part of 'settings_bloc.dart';

@freezed
sealed class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(ThemeMode.light) ThemeMode themeMode,
    @Default(Locale('en')) Locale locale,
  }) = _SettingsState;
}
