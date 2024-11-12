// File: lib/providers/theme_provider.dart
import 'package:flutter/material.dart';
// import 'package:shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  static const THEME_STATUS = "THEME_STATUS";
  SharedPreferences? _prefs;
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadFromPrefs();
  }

  void toggleTheme(ThemeMode themeMode) {
    _themeMode = themeMode;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    final value =
        _prefs?.getString(THEME_STATUS) ?? ThemeMode.system.toString();
    _themeMode = ThemeMode.values.firstWhere(
      (element) => element.toString() == value,
      orElse: () => ThemeMode.system,
    );
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    _prefs?.setString(THEME_STATUS, _themeMode.toString());
  }
}
