import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {

  final String _apiKey = "d3efac31381a742f9e56142eb96c2341";

  final TextEditingController _cityController = TextEditingController();

  String? _cityName;
  String? _temperature;
  String? _weatherDescription;
  String? _weatherIcon;
  bool _isLoading = false;
  String? _errorMessage;

  final List<String> _citySuggestions = [
    "London", "New York", "Paris", "Tokyo", "Delhi", "Sydney", "Moscow",
    "Dubai", "Singapore", "Toronto", "Los Angeles", "Berlin", "Chicago",
    "Madrid", "Rome", "Karachi", "Lahore", "Islamabad", "Mumbai"
  ];

  List<String> _filteredSuggestions = [];

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  void _updateSuggestions(String input) {
    if (input.isEmpty) {
      setState(() => _filteredSuggestions = []);
      return;
    }
    setState(() {
      _filteredSuggestions = _citySuggestions
          .where((city) => city.toLowerCase().startsWith(input.toLowerCase()))
          .toList();
    });
  }

  Future<void> _fetchWeather(String city) async {
    if (city.isEmpty) {
      setState(() {
        _errorMessage = "Please enter a city name";
        _cityName = null;
        _filteredSuggestions = [];
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _cityName = null;
      _filteredSuggestions = [];
    });

    final String apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$_apiKey&units=metric";

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _cityName = data['name'];
          _temperature = (data['main']['temp'] as num).toStringAsFixed(1);
          _weatherDescription = data['weather'][0]['description'];
          _weatherIcon = data['weather'][0]['icon'];
        });
      } else {
        final data = json.decode(response.body);
        String message = data['message'] ?? "City not found or error fetching data.";
        setState(() => _errorMessage = message[0].toUpperCase() + message.substring(1));
      }
    } catch (e) {
      setState(() => _errorMessage = "Failed to load weather data. Check your connection.");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      labelText: "Enter City Name",
      labelStyle: const TextStyle(color: Colors.deepPurple),
      filled: true,
      fillColor: Colors.white.withOpacity(0.9),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 2),
      ),
      prefixIcon: const Icon(Icons.location_city, color: Colors.deepPurple),
      suffixIcon: IconButton(
        icon: const Icon(Icons.search, color: Colors.deepPurple),
        onPressed: () {
          _fetchWeather(_cityController.text.trim());
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Weather App",
          style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        // Khoobsurat gradient background
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlueAccent.shade100, Colors.blue.shade600],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            children: <Widget>[
              // Search field aur suggestions
              Stack(
                children: [
                  TextField(
                    controller: _cityController,
                    decoration: _inputDecoration(),
                    onChanged: _updateSuggestions,
                    onSubmitted: (value) {
                      _fetchWeather(value.trim());
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  if (_filteredSuggestions.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 65.0),
                      child: Container(
                        height: (_filteredSuggestions.length * 55.0).clamp(0, 220.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5, spreadRadius: 1),
                          ],
                        ),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: _filteredSuggestions.length,
                          itemBuilder: (context, index) {
                            final suggestion = _filteredSuggestions[index];
                            return ListTile(
                              title: Text(suggestion),
                              onTap: () {
                                _cityController.text = suggestion;
                                setState(() => _filteredSuggestions = []);
                                _fetchWeather(suggestion);
                                FocusScope.of(context).unfocus();
                              },
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              // Weather display area
              Expanded(
                child: Center(
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : _errorMessage != null
                      ? Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )
                      : _cityName == null
                      ? // Behtar initial message
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.wb_cloudy_outlined, size: 80, color: Colors.white70),
                      SizedBox(height: 16),
                      Text(
                        "Search for a city to see the weather",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                      : // Weather display card
                  Card(
                    color: Colors.white.withOpacity(0.85),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          if (_weatherIcon != null)
                            Image.network(
                              "https://openweathermap.org/img/wn/$_weatherIcon@4x.png",
                              width: 120,
                              height: 120,
                              errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.cloud_off, size: 80, color: Colors.grey),
                            ),
                          const SizedBox(height: 10),
                          Text(
                            _cityName!,
                            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "$_temperature°C",
                            style: TextStyle(fontSize: 52, fontWeight: FontWeight.w300, color: Colors.grey.shade800),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _weatherDescription![0].toUpperCase() + _weatherDescription!.substring(1),
                            style: const TextStyle(fontSize: 22, fontStyle: FontStyle.italic, color: Colors.black54),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}