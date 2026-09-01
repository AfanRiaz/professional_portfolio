import 'package:flutter/material.dart';

class AfanIconButtonTheme {
  AfanIconButtonTheme._();

  static IconButtonThemeData lightIconButtonTheme =
  IconButtonThemeData(
    style: ButtonStyle(
      iconSize: const WidgetStatePropertyAll(28),

      // Glass circle - ALWAYS visible
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          return Colors.blue.withValues(alpha: 0.18);
        }

        if (states.contains(WidgetState.pressed)) {
          return Colors.blue.withValues(alpha: 0.25);
        }

        return Colors.blue.withValues(alpha: 0.08);
      }),

      foregroundColor: const WidgetStatePropertyAll(
          Color.fromARGB(255, 45, 51, 107)
      ),

      // Border
      side: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          return const BorderSide(
            color: Colors.blue,
            width: 1.5,
          );
        }

        return BorderSide(
          color: Colors.blue.withValues(alpha: 0.25),
          width: 1,
        );
      }),

      // Make it a circle
      shape: const WidgetStatePropertyAll(
        CircleBorder(),
      ),

      // Slight elevation on hover
      elevation: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          return 5;
        }

        return 1;
      }),

      // IMPORTANT:
      // Increase this to make the glass circle bigger
      minimumSize: const WidgetStatePropertyAll(
        Size(50, 50),
      ),

      maximumSize: const WidgetStatePropertyAll(
        Size(50, 50),
      ),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.zero,
      ),


      animationDuration: const Duration(
        milliseconds: 200,
      ),
    ),
  );

  static IconButtonThemeData darkIconButtonTheme =
  IconButtonThemeData(
    style: ButtonStyle(
      iconSize: const WidgetStatePropertyAll(28),

      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          return Colors.blue.withValues(alpha: 0.18);
        }

        if (states.contains(WidgetState.pressed)) {
          return Colors.blue.withValues(alpha: 0.25);
        }

        return Colors.white.withValues(alpha: 0.08);
      }),

      foregroundColor: const WidgetStatePropertyAll(
        Colors.white,
      ),

      side: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          return const BorderSide(
            color: Colors.blue,
            width: 1.5,
          );
        }

        return BorderSide(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        );
      }),

      shape: const WidgetStatePropertyAll(
        CircleBorder(),

      ),

      elevation: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          return 5;
        }


        return 1;
      }),
      minimumSize: const WidgetStatePropertyAll(
        Size(50, 50),
      ),

      maximumSize: const WidgetStatePropertyAll(
        Size(50, 50),
      ),

      padding: const WidgetStatePropertyAll(
        EdgeInsets.zero,
      ),

      animationDuration: const Duration(
        microseconds: 1,
      ),
    ),
  );
}