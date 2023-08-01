import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsnewscollect/screens/home_screen.dart';

void main() {
  final String apiKey = 'apikey 64uwmp9Gd42pXYiQJCxxun:2znBzmkUH17dnUs1kKQr2b';
  final String apiUrl = 'https://api.collectapi.com/news/getNews?country=tr&tag=general';

  runApp(MyApp(apiKey: apiKey, apiUrl: apiUrl));
}

class MyApp extends StatelessWidget {
  final String apiKey;
  final String apiUrl;

  const MyApp({required this.apiKey, required this.apiUrl, Key? key}) : super(key: key);

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
      home: HomeScreen(apiKey: apiKey, apiUrl: apiUrl),
    );
  }
}