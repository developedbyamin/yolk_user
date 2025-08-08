import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesStorage {
  static late SharedPreferences _prefs;

  // Initialize SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save data
  static Future<bool> saveString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  static Future<bool> saveInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  static Future<bool> saveBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  // Retrieve data
  static String? getString(String key) {
    return _prefs.getString(key);
  }

  static int? getInt(String key) {
    return _prefs.getInt(key);
  }

  static bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  // Remove data
  static Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  // Clear all stored data
  static Future<void> clear() async {
    await _prefs.clear();
  }
}
