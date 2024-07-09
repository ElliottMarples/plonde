import 'package:flutter/material.dart';

class SettingsNotifier with ChangeNotifier {
  bool _isDarkMode = true;

  bool get isDarkMode => _isDarkMode;

  void setDarkMode(bool darkMode) {
    _isDarkMode = darkMode;
    notifyListeners();
  }
}
