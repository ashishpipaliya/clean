import 'package:clean/core/error/error_handler.dart';
import 'package:clean/core/error/failures.dart';
import 'package:clean/features/settings/data/datasource/settings_local_data_source.dart';
import 'package:clean/features/settings/domain/repository/settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource _localDataSource;

  SettingsRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, ThemeMode>> getThemeMode() async {
    try {
      final index = await _localDataSource.getThemeModeIndex();
      final mode = ThemeMode.values[int.tryParse(index ?? '0') ?? 0];
      return right(mode);
    } catch (e) {
      return left(ErrorHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveThemeMode(ThemeMode mode) async {
    try {
      await _localDataSource.saveThemeModeIndex(mode.index);
      return right(unit);
    } catch (e) {
      return left(ErrorHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, Locale>> getLocale() async {
    try {
      final code = await _localDataSource.getLocaleCode();
      return right(Locale(code ?? 'en'));
    } catch (e) {
      return left(ErrorHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveLocale(Locale locale) async {
    try {
      await _localDataSource.saveLocaleCode(locale.languageCode);
      return right(unit);
    } catch (e) {
      return left(ErrorHandler.handleException(e));
    }
  }
}
