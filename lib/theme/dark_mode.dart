import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(

  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    primary: Colors.grey.shade600,
    secondary: Colors.grey.shade700,
    inversePrimary: Colors.grey.shade300,
    tertiary: Colors.grey.shade800,
    surfaceDim: Colors.grey.shade800,
    scrim: Colors.grey.shade300,
    surfaceTint: Colors.grey.shade300,
      tertiaryContainer: Colors.white
  ),

  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.grey.shade300,
    selectionColor: Colors.grey.shade700,
    selectionHandleColor: Colors.grey.shade400,
  ),

  checkboxTheme: CheckboxThemeData(
    checkColor: WidgetStateProperty.all(Colors.white),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.orangeAccent;
      }
      return Colors.grey;
    }),
  ),

);