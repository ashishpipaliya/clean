import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

@module
abstract class HiveModule {
  @preResolve
  @singleton
  Future<HiveInterface> get hive async {
    final appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);
    return Hive;
  }
}

@lazySingleton
class HiveService {
  final HiveInterface _hive;

  HiveService(this._hive);

  /// Open a box for a specific type
  Future<Box<T>> openBox<T>(String boxName) async {
    if (_hive.isBoxOpen(boxName)) {
      return _hive.box<T>(boxName);
    }
    return await _hive.openBox<T>(boxName);
  }

  /// Save data to a box
  Future<void> put<T>(String boxName, String key, T value) async {
    final box = await openBox<T>(boxName);
    await box.put(key, value);
  }

  /// Get data from a box
  Future<T?> get<T>(String boxName, String key) async {
    final box = await openBox<T>(boxName);
    return box.get(key);
  }

  /// Delete data from a box
  Future<void> delete(String boxName, String key) async {
    final box = await openBox(boxName);
    await box.delete(key);
  }

  /// Clear all data in a box
  Future<void> clearBox(String boxName) async {
    final box = await openBox(boxName);
    await box.clear();
  }

  /// Close a box
  Future<void> closeBox(String boxName) async {
    if (_hive.isBoxOpen(boxName)) {
      await _hive.box(boxName).close();
    }
  }
}
