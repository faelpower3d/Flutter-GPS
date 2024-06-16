import 'package:flutter/material.dart';
import 'menuFirestore.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Localização',
      theme: ThemeData(
      ),
      home: MenuFirestore(),
    );
  }
}