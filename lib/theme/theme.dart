import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade200,
    primary: Colors.grey.shade500,
    secondary: Colors.grey.shade300,
    inversePrimary: Colors.grey.shade900,
  ),
);

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.grey.shade600,
    secondary: Colors.grey.shade800,
    inversePrimary: Colors.grey.shade200,
  ),
);
