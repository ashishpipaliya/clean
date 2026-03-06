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

  Future<Box<T>> openBox<T>(String boxName) async {
    if (_hive.isBoxOpen(boxName)) {
      return _hive.box<T>(boxName);
    }
    return await _hive.openBox<T>(boxName);
  }

  Future<void> put<T>(String boxName, String key, T value) async {
    final box = await openBox<T>(boxName);
    await box.put(key, value);
  }

  Future<T?> get<T>(String boxName, String key) async {
    final box = await openBox<T>(boxName);
    return box.get(key);
  }

  Future<void> delete(String boxName, String key) async {
    final box = await openBox(boxName);
    await box.delete(key);
  }

  Future<void> clearBox(String boxName) async {
    final box = await openBox(boxName);
    await box.clear();
  }

  Future<void> closeBox(String boxName) async {
    if (_hive.isBoxOpen(boxName)) {
      await _hive.box(boxName).close();
    }
  }
}
