import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_themes/appbar_theme.dart';
import 'custom_themes/elevated_button_theme.dart';
import 'custom_themes/icon_button_theme.dart';
import 'custom_themes/text_button_theme.dart';
import 'custom_themes/text_theme.dart';

class AfanAppTheme {
  AfanAppTheme._();
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: GoogleFonts.poppins().fontFamily,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: AfanTextTheme.lightTextTheme,
    elevatedButtonTheme: AfanElevatedButtonTheme.lightElevatedButtonTheme,
    appBarTheme: AfanAppbarTheme.lightAppBarTheme,
    iconButtonTheme: AfanIconButtonTheme.lightIconButtonTheme,
    textButtonTheme: AfanTextButtonTheme.lightTextButtonTheme,

  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: GoogleFonts.poppins().fontFamily,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: const Color.fromARGB(255, 8, 13, 43),
    textTheme: AfanTextTheme.darkTextTheme,
    elevatedButtonTheme: AfanElevatedButtonTheme.darkElevatedButtonTheme,
    appBarTheme: AfanAppbarTheme.darkAppBarTheme,
    iconButtonTheme: AfanIconButtonTheme.darkIconButtonTheme,
    textButtonTheme: AfanTextButtonTheme.darkTextButtonTheme,

  );
}
