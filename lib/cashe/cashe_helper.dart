import 'package:shared_preferences/shared_preferences.dart';

/// Simple wrapper around SharedPreferences
class CacheHelper {
  static late final SharedPreferences _prefs;

  /// Initialize SharedPreferences (call once at app start)
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Save data
  static Future<bool> save({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return _prefs.setString(key, value);
    if (value is int) return _prefs.setInt(key, value);
    if (value is bool) return _prefs.setBool(key, value);
    if (value is double) return _prefs.setDouble(key, value);
    throw Exception('Unsupported type');
  }

  /// Get data
  static dynamic get(String key) => _prefs.get(key);

  static String? getString(String key) => _prefs.getString(key);

  static bool contains(String key) => _prefs.containsKey(key);

  static Future<bool> remove(String key) async => _prefs.remove(key);

  static Future<bool> clear() async => _prefs.clear();
}
