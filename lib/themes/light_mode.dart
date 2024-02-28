import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    scaffoldBackgroundColor: Colors.white,

   appBarTheme: AppBarTheme(
       backgroundColor: Colors.grey.shade100,
       foregroundColor: Colors.grey.shade800,
     iconTheme: const IconThemeData(color: Colors.black),
       centerTitle: true,
       elevation: 0,

   ),
   colorScheme:  ColorScheme.light(
    background: Colors.grey.shade300,
    primary: Colors.grey.shade600,
    secondary: Colors.grey.withOpacity(0.7),
    tertiary: Colors.white,
    inversePrimary: Colors.grey.shade900,
  )
);