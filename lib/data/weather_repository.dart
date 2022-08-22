import 'dart:convert';

import 'package:l/data/weather_data_provider.dart';
import 'package:l/data/weather_model.dart';

class WeatherRepository {
  late final WeatherDataProvider weatherApi;

  Future<Weather?> getWeatherFromLocation(String loc) async {
    final response = await WeatherDataProvider().fetchWeather(loc);

    if (response.statusCode == 200) {
      final Weather weather = Weather.fromJson(jsonDecode(response.body));
      return weather;
    } else {
      print('response when city doesnt exist= ${response}');
      print('response.body when city doesnt exist= ${response.body}');
      print(
          'jsonDecode(response.body) when city doesnt exist= ${jsonDecode(response.body)}');
      print(
          'jsonDecode(response.body)[message] when city doesnt exist= ${jsonDecode(response.body)['message']}');
      //throw Exception('Failed to load weather');
      return null;
    }
  }
}
