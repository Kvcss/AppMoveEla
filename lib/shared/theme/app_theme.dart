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
      textTheme: const TextTheme().apply(
        bodyColor: cs.onBackground,
        displayColor: cs.onBackground,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cs.surface,
        hintStyle: TextStyle(color: cs.onSurface.withOpacity(.7)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: cs.onSurface.withOpacity(.35), width: 1.2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: cs.onSurface.withOpacity(.35), width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: cs.primary, width: 1.6),
        ),
      ),
      dividerTheme: const DividerThemeData(color: MoveElaColors.divider),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: cs.primary),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: cs.onSurface.withOpacity(.35), width: 1.2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          foregroundColor: cs.onBackground,
          minimumSize: const Size.fromHeight(52),
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
      textTheme: ThemeData.dark().textTheme.apply(
        bodyColor: cs.onBackground,
        displayColor: cs.onBackground,
      ),
      // No dark do Figma os TEXTFIELDS são BRANCOS
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        hintStyle: const TextStyle(color: Color(0xFF6E5D72)), // cinza escuro sutil
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.transparent, width: 0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.transparent, width: 0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: MoveElaColors.primary, width: 1.6),
        ),
      ),
      dividerTheme: DividerThemeData(color: cs.onBackground.withOpacity(.3), thickness: 1),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: cs.onBackground),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          backgroundColor: cs.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
          foregroundColor: Colors.white,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          // Botão Google no dark do Figma é BRANCO
          backgroundColor: Colors.white,
          side: const BorderSide(color: Color(0xFFE4E1E6), width: 1.2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          foregroundColor: const Color(0xFF3C3C43), // texto escuro
          minimumSize: const Size.fromHeight(52),
        ),
      ),
    );
  }
}
