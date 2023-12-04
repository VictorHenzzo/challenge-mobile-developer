import 'package:flutter/material.dart';

class AppThemeData {
  const AppThemeData();

  ThemeData get theme => ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
      );

  static const ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF166381),
    onPrimary: Color(0xFFffffff),
    secondary: Color(0xFF202020),
    onSecondary: Color(0xFFffffff),
    error: Color(0xFFbb233e),
    onError: Color(0xFFbb233e),
    background: Color(0xFFffffff),
    onBackground: Color(0xFFffffff),
    surface: Color(0xFFffffff),
    onSurface: Color(0xFFffffff),
  );
}
