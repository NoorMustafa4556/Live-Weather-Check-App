import 'package:flutter/material.dart';
import 'package:weather_app/Weather%20App/WetaherSplash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
debugShowCheckedModeBanner: false,
      theme: ThemeData(

      ),
      home: const WeatherSplash(),
    );
  }
}


