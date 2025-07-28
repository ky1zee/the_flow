import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
    primary: Colors.grey.shade500,
    secondary: Colors.grey.shade200,
    inversePrimary: Colors.grey.shade900,
    tertiary: Colors.grey.shade200,
    surfaceDim: Colors.grey.shade400,
    scrim: Colors.grey.shade500,
    surfaceTint: Colors.grey.shade700,
    tertiaryContainer: Colors.grey.shade900
  ),

  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.grey.shade600,
    selectionColor: Colors.grey.shade400,
    selectionHandleColor: Colors.grey.shade600,
  ),

);