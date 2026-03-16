import 'package:clean/core/storage/secure_storage_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SettingsLocalDataSource {
  final SecureStorageService _secureStorage;

  static const _themeModeKey = 'theme_mode';
  static const _localeKey = 'locale';

  SettingsLocalDataSource(this._secureStorage);

  Future<String?> getThemeModeIndex() => _secureStorage.read(_themeModeKey);
  Future<void> saveThemeModeIndex(int index) =>
      _secureStorage.write(_themeModeKey, index.toString());

  Future<String?> getLocaleCode() => _secureStorage.read(_localeKey);
  Future<void> saveLocaleCode(String code) =>
      _secureStorage.write(_localeKey, code);
}
