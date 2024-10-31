import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class LoginProvider with ChangeNotifier {
  String? _login;
  String? _password;

  String? get login => _login;
  String? get password => _password;

  Future<void> loadLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _login = prefs.getString('login');
    _password = prefs.getString('password');
    notifyListeners();
  }

  Future<void> saveLogin(String login, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('login', login);
    await prefs.setString('password', password);
    _login = login;
    _password = password;
    notifyListeners();
  }

  Future<void> clearLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('login');
    await prefs.remove('password');
    _login = null;
    _password = null;
    notifyListeners();
  }
}
