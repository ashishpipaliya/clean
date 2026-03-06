import 'package:clean/core/storage/secure_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'settings_event.dart';
part 'settings_state.dart';
part 'settings_bloc.freezed.dart';

@singleton
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SecureStorageService _secureStorage;

  static const String _themeModeKey = 'theme_mode';
  static const String _localeKey = 'locale';

  SettingsBloc(this._secureStorage) : super(const SettingsState()) {
    on<_LoadSettings>(_onLoadSettings);
    on<_ChangeTheme>(_onChangeTheme);
    on<_ChangeLocale>(_onChangeLocale);

    // Load settings on initialization
    add(const SettingsEvent.loadSettings());
  }

  Future<void> _onLoadSettings(
    _LoadSettings event,
    Emitter<SettingsState> emit,
  ) async {
    final themeModeIndex = await _secureStorage.read(_themeModeKey);
    final localeCode = await _secureStorage.read(_localeKey);

    emit(state.copyWith(
      themeMode: ThemeMode.values[int.tryParse(themeModeIndex ?? '0') ?? 0],
      locale: Locale(localeCode ?? 'en'),
    ));
  }

  Future<void> _onChangeTheme(
    _ChangeTheme event,
    Emitter<SettingsState> emit,
  ) async {
    await _secureStorage.write(_themeModeKey, event.themeMode.index.toString());
    emit(state.copyWith(themeMode: event.themeMode));
  }

  Future<void> _onChangeLocale(
    _ChangeLocale event,
    Emitter<SettingsState> emit,
  ) async {
    await _secureStorage.write(_localeKey, event.locale.languageCode);
    emit(state.copyWith(locale: event.locale));
  }
}
