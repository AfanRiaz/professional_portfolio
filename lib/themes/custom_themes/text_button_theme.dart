import 'package:flutter/material.dart';

class AfanTextButtonTheme {
  AfanTextButtonTheme._();

  static TextButtonThemeData lightTextButtonTheme =
  TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.blue.withValues(alpha: 0.10);
        }

        if (states.contains(WidgetState.hovered)) {
          return Colors.blue.withValues(alpha: 0.05);
        }

        return Colors.transparent;
      }),

      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.blue;
        }

        if (states.contains(WidgetState.hovered)) {
          return Colors.deepPurpleAccent;
        }
        else{
          return Color.fromARGB(255, 79, 89, 145);
        }
        return Colors.black87;
      }),

      side: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const BorderSide(
            color: Colors.blue,
            width: 1.5,
          );
        }

// Completely invisible
        return BorderSide.none;
      }),

      shape: const WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),

      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 12,
        ),
      ),

      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return Colors.blue.withValues(alpha: 0.10);
        }

        return Colors.transparent;
      }),

      animationDuration: const Duration(
        milliseconds: 200,
      ),
    ),
  );
  static TextButtonThemeData darkTextButtonTheme =
  TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.blue.withValues(alpha: 0.15);
        }

        if (states.contains(WidgetState.hovered)) {
          return Colors.white.withValues(alpha: 0.05);
        }

        return Colors.transparent;
      }),

      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.blue;
        }

        if (states.contains(WidgetState.hovered)) {
          return Colors.blue;
        }

        return Colors.white70;
      }),

      side: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const BorderSide(
            color: Colors.blue,
            width: 1.5,
          );
        }

        return BorderSide.none;
      }),

      shape: const WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),

      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 12,
        ),
      ),

      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return Colors.blue.withValues(alpha: 0.15);
        }

        return Colors.transparent;
      }),

      animationDuration: const Duration(
        milliseconds: 200,
      ),
    ),
  );
}