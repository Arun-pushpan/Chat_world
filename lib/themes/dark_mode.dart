import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.grey.shade900,
      iconTheme: const IconThemeData(color: Colors.white),
      centerTitle: true,
      elevation: 0,
    ),
    colorScheme: ColorScheme.dark(
      background: Colors.grey.shade900,
      primary: Colors.grey.shade600,
      secondary: Colors.grey.shade700,
      tertiary: Colors.grey.shade900,
      inversePrimary: Colors.grey.shade100,
    ));
