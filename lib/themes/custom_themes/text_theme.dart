import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AfanTextTheme {
  AfanTextTheme._();

  // ================= LIGHT COLORS =================

  static const Color lightHeadingColor =
  Color.fromARGB(255, 45, 51, 107); // #2D336B

  static const Color lightBodyColor =
  Color.fromARGB(255, 90, 97, 142); // #5A618E

  static const Color lightSecondaryColor =
  Color.fromARGB(255, 124, 126, 162); // #7C7EA2


  // ================= DARK COLORS =================

  static const Color darkHeadingColor =
  Color.fromARGB(255, 255, 242, 242); // #FFF2F2

  static const Color darkBodyColor =
  Color.fromARGB(255, 169, 181, 223); // #A9B5DF

  static const Color darkSecondaryColor =
  Color.fromARGB(255, 196, 191, 207); // Soft secondary


  // ================= LIGHT TEXT THEME =================

  static TextTheme lightTextTheme = TextTheme(

    bodyLarge: TextStyle(
      fontSize: 22,
      color: lightBodyColor,
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontWeight: FontWeight.w400,
    ),

    bodyMedium: TextStyle(
      fontSize: 20,
      color: lightBodyColor,
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontWeight: FontWeight.w400,
    ),

    bodySmall: TextStyle(
      fontSize: 18,
      color: lightSecondaryColor,
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontWeight: FontWeight.w400,
    ),


    // ================= HEADLINES =================

    headlineLarge: TextStyle(
      fontSize: 28,
      color: lightHeadingColor,
      fontFamily: GoogleFonts.montserrat().fontFamily,
      fontWeight: FontWeight.w900,
    ),

    headlineMedium: TextStyle(
      fontSize: 26,
      color: lightHeadingColor,
      fontFamily: GoogleFonts.montserrat().fontFamily,
      fontWeight: FontWeight.w800,
    ),

    headlineSmall: TextStyle(
      fontSize: 24,
      color: lightHeadingColor,
      fontFamily: GoogleFonts.montserrat().fontFamily,
      fontWeight: FontWeight.w700,
    ),


    // ================= TITLES =================

    titleLarge: TextStyle(
      fontSize: 18,
      color: lightHeadingColor,
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontWeight: FontWeight.w600,
    ),

    titleMedium: TextStyle(
      fontSize: 16,
      color: lightBodyColor,
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontWeight: FontWeight.w500,
    ),

    titleSmall: TextStyle(
      fontSize: 14,
      color: lightSecondaryColor,
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontWeight: FontWeight.w400,
    ),
  );


  // ================= DARK TEXT THEME =================

  static TextTheme darkTextTheme = TextTheme(

    bodyLarge: TextStyle(
      fontSize: 22,
      color: darkBodyColor,
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontWeight: FontWeight.w400,
    ),

    bodyMedium: TextStyle(
      fontSize: 20,
      color: darkBodyColor,
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontWeight: FontWeight.w400,
    ),

    bodySmall: TextStyle(
      fontSize: 18,
      color: darkSecondaryColor,
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontWeight: FontWeight.w400,
    ),


    // ================= HEADLINES =================

    headlineLarge: TextStyle(
      fontSize: 28,
      color: darkHeadingColor,
      fontFamily: GoogleFonts.montserrat().fontFamily,
      fontWeight: FontWeight.w900,
    ),

    headlineMedium: TextStyle(
      fontSize: 26,
      color: darkHeadingColor,
      fontFamily: GoogleFonts.montserrat().fontFamily,
      fontWeight: FontWeight.w800,
    ),

    headlineSmall: TextStyle(
      fontSize: 24,
      color: darkHeadingColor,
      fontFamily: GoogleFonts.montserrat().fontFamily,
      fontWeight: FontWeight.w700,
    ),


    // ================= TITLES =================

    titleLarge: TextStyle(
      fontSize: 18,
      color: darkHeadingColor,
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontWeight: FontWeight.w600,
    ),

    titleMedium: TextStyle(
      fontSize: 16,
      color: darkBodyColor,
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontWeight: FontWeight.w500,
    ),

    titleSmall: TextStyle(
      fontSize: 14,
      color: darkSecondaryColor,
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontWeight: FontWeight.w400,
    ),
  );
}