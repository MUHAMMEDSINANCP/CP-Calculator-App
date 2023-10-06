import 'package:calculator_app/calculator_ui.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: CalculatorUi(),
      theme: ThemeData(
        primaryColor: Colors.white,
        hintColor: Colors.black,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

