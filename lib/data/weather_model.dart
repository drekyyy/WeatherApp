import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class Weather {
  String city;
  String weather;
  String icon;
  double temperature;
  double temperatureMin;
  double temperatureMax;
  double pressure;
  double windSpeed;
  double humidity;

  Weather({
    required this.city,
    required this.weather,
    required this.icon,
    required this.temperature,
    required this.temperatureMin,
    required this.temperatureMax,
    required this.pressure,
    required this.windSpeed,
    required this.humidity,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['name'],
      weather: json['weather.main'],
      icon: json['weather.icon'],
      temperature: json['main.temp'],
      temperatureMin: json['main.temp_min'],
      temperatureMax: json['main.temp_max'],
      pressure: json['main.pressure'],
      windSpeed: json['wind.speed'],
      humidity: json['main.humidity'],
    );
  }
}
