import 'package:chat_with_friends/firebase_options.dart';
import 'package:chat_with_friends/themes/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Create an instance of ThemeProvider and load the theme mode from SharedPreferences
  ThemeProvider themeProvider = ThemeProvider();
  await themeProvider.loadThemeModeFromPrefs();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ChangeNotifierProvider(
      create: (context) => themeProvider, // Pass the existing instance here
      child:  MyApp(themeProvider: themeProvider),
    ),
  );
}

