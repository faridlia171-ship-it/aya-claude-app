import 'package:flutter/material.dart';

class AppTheme {
  // Islamic Colors
  static const Color _primaryGreen = Color(0xFF2E7D32);
  static const Color _islamicGold = Color(0xFFFDD835);
  static const Color _darkBackground = Color(0xFF1A1A1A);
  static const Color _lightBackground = Color(0xFFFAFAFA);

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryGreen,
      brightness: Brightness.light,
      primary: _primaryGreen,
      secondary: _islamicGold,
      surface: _lightBackground,
    ),
    typography: Typography.material2021(
      englishLike: Typography.englishLike2021,
      dense: Typography.dense2021,
      tall: Typography.tall2021,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: _primaryGreen,
      elevation: 2,
      centerTitle: false,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryGreen,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    scaffoldBackgroundColor: _lightBackground,
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.white,
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryGreen,
      brightness: Brightness.dark,
      primary: _primaryGreen,
      secondary: _islamicGold,
      surface: _darkBackground,
    ),
    typography: Typography.material2021(
      englishLike: Typography.englishLike2021,
      dense: Typography.dense2021,
      tall: Typography.tall2021,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF0D3B1F),
      elevation: 2,
      centerTitle: false,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryGreen,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    scaffoldBackgroundColor: _darkBackground,
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Color(0xFF2A2A2A),
    ),
  );
}
