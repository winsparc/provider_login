import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  String? token;

  Future<void> loadLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token");
    _isLoggedIn = token != null;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    print('email');
    print(email);
    print('password');
    print(password);
    final res = await AuthService.login(email, password);
    print('login api');
    print(res);

    if (res["success"] == true) {
      token = res["data"]["token"];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", token!);

      _isLoggedIn = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    token = null;
    _isLoggedIn = false;
    notifyListeners();
  }
}
