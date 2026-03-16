import 'package:clean/features/settings/domain/repository/settings_repository.dart';
import 'package:clean/features/settings/domain/usecase/logout_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'settings_event.dart';
part 'settings_state.dart';
part 'settings_bloc.freezed.dart';

@singleton
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _settingsRepository;
  final LogoutUsecase _logoutUsecase;

  SettingsBloc(this._settingsRepository, this._logoutUsecase)
      : super(const SettingsState()) {
    on<_LoadSettings>(_onLoadSettings);
    on<_ChangeTheme>(_onChangeTheme);
    on<_ChangeLocale>(_onChangeLocale);
    on<_Logout>(_onLogout);

    add(const SettingsEvent.loadSettings());
  }

  Future<void> _onLoadSettings(
    _LoadSettings event,
    Emitter<SettingsState> emit,
  ) async {
    final themeResult = await _settingsRepository.getThemeMode();
    final localeResult = await _settingsRepository.getLocale();

    emit(state.copyWith(
      themeMode: themeResult.getOrElse((_) => ThemeMode.system),
      locale: localeResult.getOrElse((_) => const Locale('en')),
    ));
  }

  Future<void> _onChangeTheme(
    _ChangeTheme event,
    Emitter<SettingsState> emit,
  ) async {
    await _settingsRepository.saveThemeMode(event.themeMode);
    emit(state.copyWith(themeMode: event.themeMode));
  }

  Future<void> _onChangeLocale(
    _ChangeLocale event,
    Emitter<SettingsState> emit,
  ) async {
    await _settingsRepository.saveLocale(event.locale);
    emit(state.copyWith(locale: event.locale));
  }

  Future<void> _onLogout(
    _Logout event,
    Emitter<SettingsState> emit,
  ) async {
    final result = await _logoutUsecase();
    result.fold(
      (_) => emit(state.copyWith(loggedOut: false)),
      (_) => emit(state.copyWith(loggedOut: true)),
    );
  }
}
