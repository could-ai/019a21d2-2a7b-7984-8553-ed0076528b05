import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');
  bool _isDarkMode = false;

  Locale get locale => _locale;
  bool get isDarkMode => _isDarkMode;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}