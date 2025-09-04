import 'package:flutter/material.dart';
import 'moveela_colors.dart';

class AppTheme {
  static ThemeData get light {
    final cs = ColorScheme.fromSeed(
      seedColor: MoveElaColors.primary,
      brightness: Brightness.light,
      primary: MoveElaColors.primary,
      background: MoveElaColors.lightBg,
      surface: MoveElaColors.lightSurface,
      onBackground: MoveElaColors.lightOnBg,
      onSurface: MoveElaColors.lightOnSurface,
    );
    return ThemeData(
      colorScheme: cs,
      useMaterial3: true,
      scaffoldBackgroundColor: cs.background,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cs.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      dividerTheme: const DividerThemeData(color: MoveElaColors.divider),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: cs.primary),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }

  static ThemeData get dark {
    final cs = ColorScheme.fromSeed(
      seedColor: MoveElaColors.primary,
      brightness: Brightness.dark,
      primary: MoveElaColors.primary,
      background: MoveElaColors.darkBg,
      surface: MoveElaColors.darkSurface,
      onBackground: MoveElaColors.darkOnBg,
      onSurface: MoveElaColors.darkOnSurface,
    );
    return ThemeData.dark(useMaterial3: true).copyWith(
      colorScheme: cs,
      scaffoldBackgroundColor: cs.background,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cs.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      dividerTheme: const DividerThemeData(color: MoveElaColors.divider),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: cs.primary),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          backgroundColor: cs.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }
}
