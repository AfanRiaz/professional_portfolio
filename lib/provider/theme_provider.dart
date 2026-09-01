import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ThemeProvider with ChangeNotifier{
  ThemeMode themeMode = ThemeMode.system;
  void toggleTheme(){
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

}