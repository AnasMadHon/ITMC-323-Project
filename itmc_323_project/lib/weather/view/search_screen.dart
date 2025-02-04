import 'package:flutter/material.dart';
import 'result_screen.dart';
import '../Repository/repository.dart';
import '../models/model.dart';

class SearchScreen extends StatefulWidget {
  final VoidCallback toggleTheme;

  const SearchScreen({required this.toggleTheme, super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController controller = TextEditingController();
  final WeatherRepository weatherRepository = WeatherRepository();
  bool isLoading = false;
  WeatherModel? weatherData;
  String? errorMessage;

  void navigateToResultScreen(String city) {
    if (city.isEmpty) {
      setState(() {
        errorMessage = "Please enter a city name";
      });
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(city: city),
      ),
    ).then((_) {
      setState(() {
        errorMessage = null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        actions: [
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.wb_sunny_outlined
                  : Icons.nightlight_round_outlined,
            ),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: 'Enter city name',
                ),
              ),
            ),
            if (errorMessage != null) ...[
              Text(
                errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            ],
            TextButton(
              onPressed: () => navigateToResultScreen(controller.text),
              child: Text("Get Weather"),
            ),
          ],
        ),
      ),
    );
  }
}
