import 'package:chat_with_friends/themes/dark_mode.dart';
import 'package:chat_with_friends/themes/light_mode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    _saveThemeModeToPrefs();
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }

  // Save the current theme mode to SharedPreferences
  Future<void> _saveThemeModeToPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('theme_mode', _themeData == lightMode ? 'light' : 'dark');
  }

  // Retrieve the theme mode from SharedPreferences
  Future<void> loadThemeModeFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? savedThemeMode = prefs.getString('theme_mode');

    if (savedThemeMode == 'dark') {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
