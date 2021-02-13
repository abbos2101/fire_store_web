import 'dart:io';
import 'package:hive/hive.dart';

enum HiveKeys { USER_ID }

class HiveDB {
  final String key = 'tune';
  Box _box;

  Future<Box> _getBox() async {
    if (_box != null) return _box;
    Directory dir = Directory("dir");
    Hive.init(dir.path);
    _box = await Hive.openBox("$key");
    return _box;
  }

  Future<void> saveUserId(String data) async =>
      (await _getBox()).put("${HiveKeys.USER_ID}", data);

  Future<String> getUserId() async =>
      (await _getBox()).get("${HiveKeys.USER_ID}");

  void close() => _box.close();

  void clear() => _box.clear();
}
