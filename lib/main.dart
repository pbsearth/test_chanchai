import 'package:flutter/material.dart';
import 'package:test_flutter/check_display.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: false,
      ),
      builder: (context, child) {
        return SafeArea(
          child: child!,
        );
      },
      home: const OrientationExample(),
    );
  }
}
