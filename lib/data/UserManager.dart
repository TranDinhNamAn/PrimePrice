import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/User.dart';

class UserManager {
  static String _keyUser = 'user';

  static Future<void> saveUser(UserModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userJson = json.encode(user.toJson());
    await prefs.setString(_keyUser, userJson);
  }

  static Future<UserModel?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userJson = prefs.getString(_keyUser);
    if (userJson != null) {
      final userMap = json.decode(userJson);
      return UserModel.fromJson(userMap);
    }
    return null;
  }

  static Future<bool> checkUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_keyUser);
  }

  static Future<void> removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_keyUser);
  }
}
