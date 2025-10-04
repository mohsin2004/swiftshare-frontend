// services/auth_service.dart
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  bool _isLoggedIn = false;
  String _userName = '';
  String _userEmail = '';

  bool get isLoggedIn => _isLoggedIn;
  String get userName => _userName;
  String get userEmail => _userEmail;

  AuthService() {
    _loadAuthState();
  }

  _loadAuthState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    _userName = prefs.getString('userName') ?? '';
    _userEmail = prefs.getString('userEmail') ?? '';
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    if (email.isNotEmpty && password.isNotEmpty) {
      _isLoggedIn = true;
      _userEmail = email;
      _userName = email.split('@')[0]; // Use email prefix as name
      
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userName', _userName);
      await prefs.setString('userEmail', _userEmail);
      
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> signup(String fullName, String email, String password) async {
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    if (fullName.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      _isLoggedIn = true;
      _userName = fullName;
      _userEmail = email;
      
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userName', _userName);
      await prefs.setString('userEmail', _userEmail);
      
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    _userName = '';
    _userEmail = '';
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    
    notifyListeners();
  }

  Future<bool> resetPassword(String email) async {
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    return email.isNotEmpty;
  }

  void signOut() {
    _userName = '';
    _userEmail = '';
    notifyListeners();
  }
}