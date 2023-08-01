import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green[900],
        hintColor: Colors.green,
        scaffoldBackgroundColor: Colors.green[800],
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.green,
        ),
      ),
      home: HomeScreen(),
    );
  }
}