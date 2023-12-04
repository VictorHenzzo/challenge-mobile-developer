import 'package:flutter/material.dart';

class AppThemeData {
  const AppThemeData();

  ThemeData get theme => ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        textTheme: textTheme,
        appBarTheme: appBarTheme(),
        bottomNavigationBarTheme: bottomNavigationBarTheme(),
        elevatedButtonTheme: elevatedButtonTheme(),
        outlinedButtonTheme: outlinedButtonThemeData(),
        textButtonTheme: textButtonTheme(),
        inputDecorationTheme: inputDecorationTheme(),
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
    outline: Color(0xFF999696),
  );

  static const TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(
      color: Colors.black,
      fontSize: 44,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700,
    ),
    displayMedium: TextStyle(
      color: Colors.black,
      fontSize: 36,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700,
    ),
    displaySmall: TextStyle(
      color: Colors.black,
      fontSize: 28,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700,
    ),
    headlineLarge: TextStyle(
      color: Colors.black,
      fontSize: 32,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w600,
    ),
    headlineMedium: TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TextStyle(
      color: Colors.black,
      fontSize: 22,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w600,
    ),
    titleLarge: TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w600,
    ),
    titleSmall: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      color: Colors.black,
      fontSize: 12,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
    ),
    labelLarge: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w600,
    ),
    labelMedium: TextStyle(
      color: Colors.black,
      fontSize: 12,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w600,
    ),
    labelSmall: TextStyle(
      color: Colors.black,
      fontSize: 11,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
    ),
  );

  AppBarTheme appBarTheme() => AppBarTheme(
        elevation: 0,
        color: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      );

  ElevatedButtonThemeData elevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        overlayColor: MaterialStatePropertyAll(
          colorScheme.onPrimary.withOpacity(0.3),
        ),
        foregroundColor: MaterialStatePropertyAll(
          colorScheme.onPrimary,
        ),
        backgroundColor: MaterialStateColor.resolveWith((final states) {
          if (states.contains(MaterialState.disabled)) {
            return colorScheme.primary.withOpacity(0.5);
          }

          return colorScheme.primary;
        }),
        elevation: const MaterialStatePropertyAll(0),
        textStyle: MaterialStatePropertyAll(
          textTheme.titleMedium,
        ),
        minimumSize: const MaterialStatePropertyAll(
          Size.fromHeight(50),
        ),
        maximumSize: const MaterialStatePropertyAll(
          Size.fromHeight(50),
        ),
      ),
    );
  }

  OutlinedButtonThemeData outlinedButtonThemeData() {
    return OutlinedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        foregroundColor:
            MaterialStateProperty.resolveWith<Color>((final states) {
          if (states.contains(MaterialState.disabled)) {
            return colorScheme.primary.withOpacity(0.5);
          }

          return colorScheme.primary;
        }),
        side: MaterialStateProperty.resolveWith((final states) {
          Color color = colorScheme.primary;

          if (states.contains(MaterialState.disabled)) {
            color = colorScheme.primary.withOpacity(0.5);
          }

          return BorderSide(
            color: color,
            width: 2,
          );
        }),
        minimumSize: const MaterialStatePropertyAll(
          Size.fromHeight(50),
        ),
        maximumSize: const MaterialStatePropertyAll(
          Size.fromHeight(50),
        ),
        elevation: const MaterialStatePropertyAll(0),
        textStyle: MaterialStatePropertyAll(
          textTheme.titleMedium,
        ),
      ),
    );
  }

  TextButtonThemeData textButtonTheme() {
    return TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStatePropertyAll(
          colorScheme.primary,
        ),
        elevation: const MaterialStatePropertyAll(0),
        textStyle: MaterialStatePropertyAll(
          textTheme.titleSmall,
        ),
        overlayColor: const MaterialStatePropertyAll(
          Colors.transparent,
        ),
        splashFactory: NoSplash.splashFactory,
      ),
    );
  }

  BottomNavigationBarThemeData bottomNavigationBarTheme() {
    return BottomNavigationBarThemeData(
      backgroundColor: colorScheme.surfaceVariant,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: colorScheme.primary,
      selectedLabelStyle: textTheme.labelMedium,
      unselectedItemColor: colorScheme.outline,
      unselectedLabelStyle: textTheme.labelSmall,
    );
  }

  InputDecorationTheme inputDecorationTheme() {
    return InputDecorationTheme(
      focusColor: colorScheme.secondary,
      constraints: const BoxConstraints(
        minHeight: 50,
      ),
      errorMaxLines: 3,
      iconColor: colorScheme.error,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 16,
      ),
      filled: true,
      prefixIconColor: colorScheme.tertiary,
      suffixIconColor: colorScheme.tertiary,
      fillColor: MaterialStateColor.resolveWith((final states) {
        if (states.contains(MaterialState.disabled)) {
          return colorScheme.outline.withOpacity(0.2);
        }

        return colorScheme.background;
      }),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: colorScheme.secondary,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: colorScheme.error,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: colorScheme.error,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: colorScheme.outline,
        ),
      ),
    );
  }
}
