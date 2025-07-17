
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'WeatherSignUp.dart';
class WeatherSplash extends StatefulWidget {
  const WeatherSplash({super.key});

  @override
  State<WeatherSplash> createState() => _WeatherSplashState();
}

class _WeatherSplashState extends State<WeatherSplash> {
  @override
  void initState() {
    super.initState();
    // Navigate after 2 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WeatherSignUp()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.orangeAccent,
              Colors.yellow,
              Colors.blue,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Sun icon
              Icon(
                Icons.wb_sunny,
                size: 150,
                color: Colors.yellow,
              ),
              const SizedBox(height: 10),
              // Cloud icon
              Icon(
                Icons.cloud,
                size: 150,
                color: Colors.white,
              ),
              const SizedBox(height: 20),
              const Text(
                'Welcome to\nWeather App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),

              // SpinKit Waves
              const SpinKitWave(
                color: Colors.white, // Wave color
                size: 70.0, // Wave size
              ),
              const SizedBox(height: 30),
              const Text(
                'please Wait....!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Where you can check\nthe weather forecast\nof your city',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
