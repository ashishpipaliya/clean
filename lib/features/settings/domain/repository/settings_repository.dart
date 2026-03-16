import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:clean/core/error/failures.dart';

abstract class SettingsRepository {
  Future<Either<Failure, ThemeMode>> getThemeMode();
  Future<Either<Failure, Unit>> saveThemeMode(ThemeMode mode);
  Future<Either<Failure, Locale>> getLocale();
  Future<Either<Failure, Unit>> saveLocale(Locale locale);
}
