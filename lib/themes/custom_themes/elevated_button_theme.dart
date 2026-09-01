import 'package:flutter/material.dart';

class AfanElevatedButtonTheme {
  AfanElevatedButtonTheme._();
  // light Theme
  static ElevatedButtonThemeData lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 5,
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      side: BorderSide(color: Colors.blue),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      disabledBackgroundColor: Colors.green,
      disabledForegroundColor: Colors.green,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 30),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)
    ),
  );

  // Dark theme
  static ElevatedButtonThemeData darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      side: BorderSide(color: Colors.blue),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      disabledBackgroundColor: Colors.green,
      disabledForegroundColor: Colors.green,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 30),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)
    ),
  );
}