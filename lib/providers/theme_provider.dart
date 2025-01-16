import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _currentTheme = ThemeData.light(); // Default to light theme

  ThemeData get currentTheme => _currentTheme;

  void toggleTheme() {
    if (_currentTheme == ThemeData.light()) {
      _currentTheme = ThemeData.dark(); // Switch to dark theme
    } else {
      _currentTheme = ThemeData.light(); // Switch to light theme
    }
    notifyListeners(); // Notify listeners to rebuild the UI
  }

  void setTheme(String theme) {
    if (theme == 'dark') {
      _currentTheme = ThemeData.dark();
    } else {
      _currentTheme = ThemeData.light();
    }
    notifyListeners();
  }
}
