import 'package:shared_preferences/shared_preferences.dart';

class Spreferences {
  static SharedPreferences? _preferences;

  static const _keyIsLogin = 'keyIsLogin';
  static const _keyDbCurrentUserId = 'keyDbCurrentUserId';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setIsLogin(bool isLogin) async =>
      await _preferences!.setBool(_keyIsLogin, isLogin);

  static bool? getIsLogin() => _preferences!.getBool(_keyIsLogin);

  static Future setCurrentUserId(int userId) async =>
      await _preferences!.setInt(_keyDbCurrentUserId, userId);

  static int? getCurrentUserId() => _preferences!.getInt(_keyDbCurrentUserId);
}
