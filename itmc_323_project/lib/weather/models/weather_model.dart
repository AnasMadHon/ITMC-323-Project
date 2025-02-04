class WeatherModel {
  final double tempC;
  final String conditionText;
  final String conditionIcon;

  WeatherModel({
    required this.tempC,
    required this.conditionText,
    required this.conditionIcon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      tempC: json['current']['temp_c'],
      conditionText: json['current']['condition']['text'],
      conditionIcon: 'https:' + json['current']['condition']['icon'],
    );
  }
}
