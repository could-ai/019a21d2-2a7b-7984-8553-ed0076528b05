import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String? _userId;
  String? _userName;
  String? _userPhone;
  String? _userEmail;
  String? _profilePicture;

  bool get isLoggedIn => _isLoggedIn;
  String? get userId => _userId;
  String? get userName => _userName;
  String? get userPhone => _userPhone;
  String? get userEmail => _userEmail;
  String? get profilePicture => _profilePicture;

  Future<void> login(String phoneOrEmail, String password) async {
    // TODO: Implement actual authentication
    _isLoggedIn = true;
    _userId = 'user123';
    _userName = 'User Name';
    _userPhone = phoneOrEmail.contains('@') ? null : phoneOrEmail;
    _userEmail = phoneOrEmail.contains('@') ? phoneOrEmail : null;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    notifyListeners();
  }

  Future<void> signup(Map<String, dynamic> userData) async {
    // TODO: Implement actual signup
    _isLoggedIn = true;
    _userId = 'user123';
    _userName = userData['name'];
    _userPhone = userData['phone'];
    _userEmail = userData['email'];
    _profilePicture = userData['profilePicture'];
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    notifyListeners();
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    _userId = null;
    _userName = null;
    _userPhone = null;
    _userEmail = null;
    _profilePicture = null;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    notifyListeners();
  }

  Future<void> updateProfile(String name, String? profilePicture) async {
    _userName = name;
    if (profilePicture != null) {
      _profilePicture = profilePicture;
    }
    notifyListeners();
  }
}