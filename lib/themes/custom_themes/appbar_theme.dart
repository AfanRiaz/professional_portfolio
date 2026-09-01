import 'package:flutter/material.dart';

class AfanAppbarTheme {
  AfanAppbarTheme._();
  static AppBarTheme lightAppBarTheme = AppBarTheme(
    backgroundColor: Colors.white.withAlpha(80),
    centerTitle: false,
    shape: const Border(
      bottom: BorderSide(
        color: Color(0x332D3A70),
        width: 1,
      ),
    ),
    elevation: 0,
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black, size: 24),
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
  );
  static AppBarTheme darkAppBarTheme = AppBarTheme(
    backgroundColor: Color.fromARGB(80, 44, 37, 100),
    centerTitle: false,
    elevation: 0,
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
    shape: const Border(
      bottom: BorderSide(
        color: Color(0x332D3A70),
        width: 1,
      ),
    ),
    iconTheme: IconThemeData(color: Colors.white, size: 24),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
  );
}