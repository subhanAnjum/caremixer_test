import 'package:flutter/material.dart';

import '../utils/app_utils.dart';

/// App theme configuration for Caremixer
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: CaremixerColors.orange,
        brightness: Brightness.light,
        primary: CaremixerColors.orange,
        secondary: CaremixerColors.green,
        surface: CaremixerColors.lightGrey,

        error: CaremixerColors.darkRed,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: CaremixerColors.orange,
        foregroundColor: CaremixerColors.white,
        elevation: 0,
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: CaremixerColors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: CaremixerColors.orange,
          foregroundColor: CaremixerColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: CaremixerColors.lightGrey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: CaremixerColors.orange, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: CaremixerColors.darkRed,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: CaremixerColors.darkRed,
            width: 2,
          ),
        ),
        hintStyle: const TextStyle(color: CaremixerColors.grey),
        labelStyle: const TextStyle(color: CaremixerColors.darkGreen),
        prefixIconColor: CaremixerColors.grey,
        suffixIconColor: CaremixerColors.grey,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: CaremixerColors.darkGreen,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: CaremixerColors.darkGreen,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: CaremixerColors.darkGreen,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: CaremixerColors.darkGreen,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: CaremixerColors.darkGreen),
        bodyMedium: TextStyle(fontSize: 14, color: CaremixerColors.darkGreen),
        bodySmall: TextStyle(fontSize: 12, color: CaremixerColors.grey),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: CaremixerColors.orange,
        brightness: Brightness.dark,
        primary: CaremixerColors.orange,
        secondary: CaremixerColors.green,
        surface: const Color(0xFF1E1E1E), // Dark grey instead of green
        surfaceContainerHighest: const Color(
          0xFF2D2D2D,
        ), // Slightly lighter grey
        error: CaremixerColors.darkRed,
      ),
      scaffoldBackgroundColor: const Color(0xFF121212), // Very dark background
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1E1E1E), // Dark grey instead of green
        foregroundColor: CaremixerColors.white,
        elevation: 0,
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF2D2D2D), // Dark grey cards
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: CaremixerColors.orange,
          foregroundColor: CaremixerColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(
          0xFF2D2D2D,
        ).withValues(alpha: 0.5), // Dark grey input fields
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: CaremixerColors.orange, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: CaremixerColors.darkRed,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: CaremixerColors.darkRed,
            width: 2,
          ),
        ),
        hintStyle: const TextStyle(color: CaremixerColors.grey),
        labelStyle: const TextStyle(color: CaremixerColors.white),
        prefixIconColor: CaremixerColors.grey,
        suffixIconColor: CaremixerColors.grey,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: CaremixerColors.white,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: CaremixerColors.white,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: CaremixerColors.white,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: CaremixerColors.white,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: CaremixerColors.white),
        bodyMedium: TextStyle(fontSize: 14, color: CaremixerColors.white),
        bodySmall: TextStyle(fontSize: 12, color: CaremixerColors.grey),
      ),
    );
  }
}
