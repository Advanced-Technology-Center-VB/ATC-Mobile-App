// Entry point
// 
// This file is the entry point for the Flutter app.
//
// Will Strong 11/7/2024

import 'package:atc_mobile_app/route/route_splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key}); 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark
      ),
      themeMode: ThemeMode.system,
      home: const RouteSplash(),
    );
  }
}
