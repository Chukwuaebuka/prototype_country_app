import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
);
final darkTheme = ThemeData(
  brightness: Brightness.dark,
);

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
