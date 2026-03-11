import 'package:film/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pilem",
      theme: ThemeData(
        primaryColor: Colors.deepPurple
      ),
      home: HomeScreen(),
    );
  }
}
