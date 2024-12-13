import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/flutter_helper_kit.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    defaultTargetPlatform;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0x0fffffff).createMaterialColor()),
        useMaterial3: true,
      ),
      home:  const HomeScreen(),
    );
  }
}
