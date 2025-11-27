import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryGreen = Color(0xFF4CAF50);
  static const Color darkGreen = Color(0xFF388E3C);
  static const Color lightGreen = Color(0xFFC8E6C9);
  static const Color accentGreen = Color(0xFF8BC34A);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xFF000000);
  static const Color greyColor = Color(0xFF9E9E9E);
  static const Color lightGreyColor = Color(0xFFE0E0E0);

  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryGreen,
    colorScheme: ColorScheme.light(
      primary: primaryGreen,
      secondary: accentGreen,
      surface: whiteColor,
      onPrimary: whiteColor,
      onSecondary: blackColor,
      onSurface: blackColor,
    ),
    scaffoldBackgroundColor: whiteColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryGreen,
      foregroundColor: whiteColor,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryGreen,
        foregroundColor: whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: primaryGreen),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: lightGreyColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: lightGreyColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: primaryGreen),
      ),
      filled: true,
      fillColor: whiteColor,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: blackColor,
      ),
      headlineMedium: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: blackColor,
      ),
      headlineSmall: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: blackColor,
      ),
      titleLarge: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: blackColor,
      ),
      titleMedium: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: blackColor,
      ),
      titleSmall: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: blackColor,
      ),
      bodyLarge: TextStyle(fontSize: 16.0, color: blackColor),
      bodyMedium: TextStyle(fontSize: 14.0, color: blackColor),
      bodySmall: TextStyle(fontSize: 12.0, color: greyColor),
    ),
  );
}
