import 'package:flutter/material.dart';
import 'package:tropico/Pages/Dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caffe Bar Tropico',
      theme: ThemeData(
        primaryColor: const Color(0xff5f3c1e), // Pastel coffee colo
        appBarTheme: const AppBarTheme(
          color: Colors.transparent, // Set the app bar color to transparent
        ),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
