import 'package:flutter/material.dart';

class ThemeService extends ChangeNotifier {
  // ChangeNotifier comes from material package
  bool isDarkModeOn = false;

  void toggleTheme() {
    isDarkModeOn = !isDarkModeOn;
    notifyListeners(); // it informs Widgets under ThemeService in the widget tree of changes made
  }
}
