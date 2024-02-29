import 'package:chat_with_friends/controller/auth/auth_gate.dart';

import 'package:chat_with_friends/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  final ThemeProvider themeProvider;
  const MyApp({super.key, required this.themeProvider});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat World',
        theme: Provider.of<ThemeProvider>(context).themeData,
        home: const AuthGate());
  }
}
