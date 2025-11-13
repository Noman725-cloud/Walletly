import 'package:flutter/material.dart';

class AppTheme {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212),
    primaryColor: const Color(0xFF00C853),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF00C853),
      secondary: Color(0xFFB0BEC5),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(fontFamily: 'Poppins'),
    ),
    cardColor: const Color(0xFF1E1E1E),
  );
}