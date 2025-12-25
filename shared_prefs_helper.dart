import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static const String _userIdKey = 'user_id';
  static const String _orgIdKey = 'org_id';
  static const String _orgCodeKey = 'org_code';
  static const String _usernameKey = 'username';
  static const String _emailKey = 'email';

  // Save user info after login
  static Future<void> saveUserInfo(Map<String, dynamic> userInfo) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userIdKey, userInfo['userid'] ?? 0);
    await prefs.setString(_orgIdKey, userInfo['orgid']?.toString() ?? '');
    await prefs.setString(_orgCodeKey, userInfo['org_code']?.toString() ?? '');
    await prefs.setString(_usernameKey, userInfo['username'] ?? '');
    await prefs.setString(_emailKey, userInfo['email'] ?? '');
  }

  // Get saved user info
  static Future<Map<String, dynamic>> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'userid': prefs.getInt(_userIdKey) ?? 0,
      'orgid': prefs.getString(_orgIdKey) ?? '',
      'org_code': prefs.getString(_orgCodeKey) ?? '',
      'username': prefs.getString(_usernameKey) ?? '',
      'email': prefs.getString(_emailKey) ?? '',
    };
  }

  // Clear user info on logout
  static Future<void> clearUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userIdKey);
    await prefs.remove(_orgIdKey);
    await prefs.remove(_orgCodeKey);
    await prefs.remove(_usernameKey);
    await prefs.remove(_emailKey);
  }
}
