import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper { // تم تعديل الاسم لـ PascalCase
  static late SharedPreferences _prefs;

  /// Initialize SharedPreferences (Call this in main.dart)
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Save data with type checking
  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await _prefs.setString(key, value);
    if (value is int) return await _prefs.setInt(key, value);
    if (value is bool) return await _prefs.setBool(key, value);
    if (value is double) return await _prefs.setDouble(key, value);
    if (value is List<String>) return await _prefs.setStringList(key, value); // إضافة دعم القوائم
    
    return false;
  }

  /// Get data generically
  static dynamic getData({required String key}) {
    return _prefs.get(key);
  }

  /// Explicitly remove a specific key
  static Future<bool> removeData({required String key}) async {
    return await _prefs.remove(key);
  }

  /// Clear all local storage
  static Future<bool> clearData() async {
    return await _prefs.clear();
  }

  /// Check if key exists
  static bool containsKey(String key) => _prefs.containsKey(key);
}