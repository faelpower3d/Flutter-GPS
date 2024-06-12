import 'package:flutter/material.dart';
import 'package:gps/home.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Localização',
      theme: ThemeData(
      ),
      home: Home(),
    );
  }
}