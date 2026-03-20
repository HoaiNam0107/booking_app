import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferencesService {
  Future<void> setString(String key, String value);
  String? getString(String key);
  Future<void> setBool(String key, bool value);
  bool? getBool(String key);
  Future<void> setInt(String key, int value);
  int? getInt(String key);
  Future<void> remove(String key);
  Future<void> clear();
}

@LazySingleton(as: PreferencesService)
class PreferencesServiceImpl implements PreferencesService {
  final SharedPreferences _prefs;

  PreferencesServiceImpl(this._prefs);

  @override
  Future<void> setString(String key, String value) async => _prefs.setString(key, value);

  @override
  String? getString(String key) => _prefs.getString(key);

  @override
  Future<void> setBool(String key, bool value) async => _prefs.setBool(key, value);

  @override
  bool? getBool(String key) => _prefs.getBool(key);

  @override
  Future<void> setInt(String key, int value) async => _prefs.setInt(key, value);

  @override
  int? getInt(String key) => _prefs.getInt(key);

  @override
  Future<void> remove(String key) async => _prefs.remove(key);

  @override
  Future<void> clear() async => _prefs.clear();
}
