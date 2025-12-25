import 'package:shared_preferences/shared_preferences.dart';

class AppPrefs {
  static const _applicationIdKey = 'application_id';
  static const _tokenKey = 'auth_token';

  static Future<void> setApplicationId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_applicationIdKey, id);
  }

  static Future<int?> getApplicationId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_applicationIdKey);
  }

  static Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
