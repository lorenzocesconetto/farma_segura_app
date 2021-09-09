import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import './auth_data.dart';

class LocalStorage {
  static const userDataKey = 'userData';

  static Future<AuthData> getUserAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(userDataKey)) {
      return null;
    }
    final userData = json.decode(prefs.getString(userDataKey));
    return AuthData.fromMap(userData);
  }

  static Future<void> saveUserAuthData(AuthData authData) async {
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode(authData.toMap());
    prefs.setString(userDataKey, userData);
  }

  static Future<void> clearUserAuth() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
    // prefs.clear();
  }
}
