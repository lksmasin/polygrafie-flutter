import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  MaterialColor _primaryColor = Colors.blue;

  ThemeMode get themeMode => _themeMode;
  MaterialColor get primaryColor => _primaryColor;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void setPrimaryColor(MaterialColor color) {
    _primaryColor = color;
    notifyListeners();
  }
}
