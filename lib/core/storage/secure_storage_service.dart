import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@module
abstract class SecureStorageModule {
  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage(
        aOptions: AndroidOptions(
        ),
      );
}

@lazySingleton
class SecureStorageService {
  final FlutterSecureStorage _secureStorage;

  SecureStorageService(this._secureStorage);

  /// Save sensitive data (tokens, credentials, etc.)
  Future<void> write(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  /// Read sensitive data
  Future<String?> read(String key) async {
    return await _secureStorage.read(key: key);
  }

  /// Delete sensitive data
  Future<void> delete(String key) async {
    await _secureStorage.delete(key: key);
  }

  /// Delete all sensitive data
  Future<void> deleteAll() async {
    await _secureStorage.deleteAll();
  }

  /// Check if key exists
  Future<bool> containsKey(String key) async {
    return await _secureStorage.containsKey(key: key);
  }

  /// Read all data
  Future<Map<String, String>> readAll() async {
    return await _secureStorage.readAll();
  }
}
