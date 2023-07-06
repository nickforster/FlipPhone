import 'package:flutter/material.dart';

void main() {
  runApp(const FlipPhoneApp());
}

class FlipPhoneApp extends StatelessWidget {

  const FlipPhoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlipPhone',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Container(),
    );
  }
}
