import 'dart:async';
import 'dart:convert';

import 'package:weather_app/data/weather_data_provider.dart';
import 'package:weather_app/data/weather_model.dart';

import 'city_model.dart';

class WeatherRepository {
  final WeatherDataProvider weatherAPI;

  WeatherRepository(this.weatherAPI);

  Future<Weather?> getWeatherFromLocation(String loc) async {
    final response = await weatherAPI.fetchWeather(loc);

    if (response.statusCode == 200) {
      final Weather weather = Weather.fromJson(jsonDecode(response.body));
      return weather;
    } else {
      //throw Exception('Failed to load weather');
      return null;
    }
  }

  Future<Cities?> getCitiesFromLocation(String loc) async {
    final response = await weatherAPI.fetchCities(loc);

    if (response.statusCode == 200) {
      //print('response.body=${response.body}');
      // print('response.body type=${response.body.runtimeType}');
      final Cities cities = Cities.fromJson(jsonDecode(response.body));
      //return cities;
      return cities;
    } else {
      //throw Exception('Failed to load weather');
      return null;
    }
  }
}
