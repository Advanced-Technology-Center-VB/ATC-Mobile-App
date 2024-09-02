import 'package:atc_mobile_app/content/route_splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key}); 

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RouteSplash(),
    );
  }
}
