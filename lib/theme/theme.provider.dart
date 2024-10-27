import 'package:flutter/material.dart';
import 'package:the_flow/theme/dark_mode.dart';
import 'package:the_flow/theme/light_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeData _themeData = lightMode;

  ThemeProvider() {
    _loadTheme();
  }

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  Future<void> _saveTheme(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  toggleTheme() async {
    if (isDarkMode) {
      _themeData = lightMode;
      await _saveTheme(false); // Save light mode theme
    } else {
      _themeData = darkMode;
      await _saveTheme(true); // Save dark mode them
    }
    notifyListeners();
  }

  Future<void> _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isDarkMode = prefs.getBool('isDarkMode');
    if (isDarkMode != null) {
      if (isDarkMode) {
        _themeData = darkMode;
      } else {
        _themeData = lightMode;
      }
      notifyListeners();
    }
  }
}