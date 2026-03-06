import 'package:clean/core/security/encryption_service.dart';
import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import 'dart:convert';

@injectable
class HomeLocalDataSource {
  static const String _cacheBox = 'pokemon_cache';
  final EncryptionService _encryptionService;

  Box<String>? _box;

  HomeLocalDataSource(this._encryptionService);

  Future<void> _init() async {
    if (!Hive.isBoxOpen(_cacheBox)) {
      _box = await Hive.openBox<String>(_cacheBox);
    } else {
      _box = Hive.box<String>(_cacheBox);
    }
  }

  Future<void> cacheData(String key, Map<String, dynamic> data) async {
    await _init();
    final jsonString = jsonEncode(data);
    final encrypted = _encryptionService.encrypt(jsonString);
    await _box?.put(key, encrypted);
  }

  Map<String, dynamic>? getCachedData(String key) {
    if (_box == null) {
      if (Hive.isBoxOpen(_cacheBox)) {
        _box = Hive.box<String>(_cacheBox);
      } else {
        return null;
      }
    }
    
    final encrypted = _box?.get(key);
    if (encrypted == null) return null;
    
    try {
      final decrypted = _encryptionService.decrypt(encrypted);
      return jsonDecode(decrypted) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  Future<void> clearCache() async {
    await _init();
    await _box?.clear();
  }
}
