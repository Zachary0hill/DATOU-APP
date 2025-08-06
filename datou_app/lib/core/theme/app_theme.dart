import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      
      // Color scheme
      colorScheme: ColorScheme.dark(
        surface: kBg,
        primary: kPrimary,
        secondary: kSecondary,
        tertiary: kAccent,
        onSurface: kText,
        onPrimary: kBg,
        onSecondary: kBg,
      ),
      
      // Scaffold
      scaffoldBackgroundColor: kBg,
      
      // Typography
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontFamily: 'BakbakOne',
          fontSize: 28,
          fontWeight: FontWeight.w800,
          color: kText,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Baloo2',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: kText,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Baloo2',
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: kText,
        ),
        bodySmall: TextStyle(
          fontFamily: 'Baloo2',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: kText,
        ),
        titleLarge: TextStyle(
          fontFamily: 'BakbakOne',
          fontSize: 24,
          fontWeight: FontWeight.w800,
          color: kText,
        ),
        titleMedium: TextStyle(
          fontFamily: 'BakbakOne',
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: kText,
        ),
      ),
      
      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: 'BakbakOne',
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: kText,
        ),
        iconTheme: IconThemeData(color: kText),
      ),
      
      // ElevatedButton
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimary,
          foregroundColor: kBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: const TextStyle(
            fontFamily: 'Baloo2',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // BottomNavigationBar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        selectedItemColor: kPrimary,
        unselectedItemColor: kText.withValues(alpha: 0.6),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: const TextStyle(
          fontFamily: 'Baloo2',
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Baloo2',
          fontWeight: FontWeight.w400,
        ),
      ),
      
      // NavigationBar (Material 3)
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        indicatorColor: kPrimary.withValues(alpha: 0.2),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              fontFamily: 'Baloo2',
              fontWeight: FontWeight.w600,
              color: kPrimary,
            );
          }
          return TextStyle(
            fontFamily: 'Baloo2',
            fontWeight: FontWeight.w400,
            color: kText.withValues(alpha: 0.6),
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: kPrimary);
          }
          return IconThemeData(color: kText.withValues(alpha: 0.6));
        }),
      ),
      
      // Card
      cardTheme: const CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
      ),
    );
  }
  
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      
      // Color scheme
      colorScheme: ColorScheme.light(
        surface: kBgLight,
        primary: kPrimary,
        secondary: kSecondary,
        tertiary: kAccent,
        onSurface: kTextLight,
        onPrimary: kBgLight,
        onSecondary: kBgLight,
      ),
      
      // Scaffold
      scaffoldBackgroundColor: kBgLight,
      
      // Typography (same structure, different colors)
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontFamily: 'BakbakOne',
          fontSize: 28,
          fontWeight: FontWeight.w800,
          color: kTextLight,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Baloo2',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: kTextLight,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Baloo2',
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: kTextLight,
        ),
        bodySmall: TextStyle(
          fontFamily: 'Baloo2',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: kTextLight,
        ),
        titleLarge: TextStyle(
          fontFamily: 'BakbakOne',
          fontSize: 24,
          fontWeight: FontWeight.w800,
          color: kTextLight,
        ),
        titleMedium: TextStyle(
          fontFamily: 'BakbakOne',
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: kTextLight,
        ),
      ),
      
      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: 'BakbakOne',
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: kTextLight,
        ),
        iconTheme: IconThemeData(color: kTextLight),
      ),
      
      // ElevatedButton
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimary,
          foregroundColor: kBgLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: const TextStyle(
            fontFamily: 'Baloo2',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // BottomNavigationBar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        selectedItemColor: kPrimary,
        unselectedItemColor: kTextLight.withValues(alpha: 0.6),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: const TextStyle(
          fontFamily: 'Baloo2',
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Baloo2',
          fontWeight: FontWeight.w400,
        ),
      ),
      
      // NavigationBar (Material 3)
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        indicatorColor: kPrimary.withValues(alpha: 0.2),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              fontFamily: 'Baloo2',
              fontWeight: FontWeight.w600,
              color: kPrimary,
            );
          }
          return TextStyle(
            fontFamily: 'Baloo2',
            fontWeight: FontWeight.w400,
            color: kTextLight.withValues(alpha: 0.6),
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: kPrimary);
          }
          return IconThemeData(color: kTextLight.withValues(alpha: 0.6));
        }),
      ),
      
      // Card
      cardTheme: const CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
      ),
    );
  }
}