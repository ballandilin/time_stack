import 'package:flutter/material.dart';

import './screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      brightness: MediaQuery.platformBrightnessOf(context),

      seedColor: Colors.white10,
    );

    return MaterialApp(
      title: 'TimeStack',
      theme: ThemeData(colorScheme: colorScheme),
      home: const MyHomePage(title: 'TimeStack'),
    );
  }
}
