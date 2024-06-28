import 'package:chat_app/Configs/Themes/dark_mode.dart';
import 'package:chat_app/Configs/Themes/light_mode.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode; // Default theme

  /// Getter for theme data
  ThemeData get themeData => _themeData;

  /// Checks if the current theme is dark mode
  bool get isDarkMode => _themeData == darkMode;

  /// Setter for theme data with change notification
  set themeData(ThemeData newTheme) {
    _themeData = newTheme;
    notifyListeners(); // Notify listeners of a change
  }

  /// Toggles between light and dark themes
  void toggleThemes() {
    themeData = (_themeData == lightMode) ? darkMode : lightMode;
  }
}
