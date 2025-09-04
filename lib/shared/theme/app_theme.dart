import 'package:flutter/material.dart';


class AppTheme {
  static ThemeData get light => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE91E63)), // rosa
    useMaterial3: true,
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
    ),
  );


  static ThemeData get dark => ThemeData.dark(useMaterial3: true);
}