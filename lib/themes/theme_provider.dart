import 'package:flutter/material.dart';
import 'package:notes_app/themes/themes.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _theme = lightMode;
  ThemeData get theme => _theme;
  bool get isDarkMode => _theme == darkMode;
  set theme(ThemeData theme) {
    _theme = theme;
    notifyListeners();
  }
  void toggleTheme() {
    _theme == lightMode ? theme = darkMode : theme = lightMode;
  }
}
