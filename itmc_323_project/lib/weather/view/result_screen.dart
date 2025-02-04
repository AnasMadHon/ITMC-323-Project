import 'package:flutter/material.dart';
import 'package:itmc_323_project/weather/models/model.dart';
import '../Repository/repository.dart';


class ResultScreen extends StatefulWidget {
  final String city;

  const ResultScreen({required this.city, super.key});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final WeatherRepository weatherRepository = WeatherRepository();
  bool isLoading = false;
  WeatherModel? weatherData;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    getWeather(widget.city);
  }

  void getWeather(String city) async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      WeatherModel data = await weatherRepository.getWeather(city);
      setState(() {
        weatherData = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading) ...[
              CircularProgressIndicator(),
            ] else if (weatherData != null) ...[
              Image.network(
                weatherData!.conditionIcon,
                width: 200,
                height: 150,
                fit: BoxFit.contain,
              ),
              Text(
                'Temperature: ${weatherData!.tempC}°C',
                style: TextStyle(fontSize: 32),
              ),
              Text(
                'Condition: ${weatherData!.conditionText}',
                style: TextStyle(fontSize: 20),
              ),
            ] else if (errorMessage != null) ...[
              Text(errorMessage!),
            ],
          ],
        ),
      ),
    );
  }
}
