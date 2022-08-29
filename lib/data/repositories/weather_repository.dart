import 'dart:async';
import 'dart:convert';

import 'package:weather_app/data/data_providers/weather_data_provider.dart';
import 'package:weather_app/data/models/locations_model.dart';
import 'package:weather_app/data/models/weather_model.dart';

class WeatherRepository {
  final WeatherDataProvider weatherAPI;

  WeatherRepository(this.weatherAPI);

  Future<Weather?> getWeatherFromLocationUsingCityName(String loc) async {
    final response = await weatherAPI.fetchWeatherUsingCityName(loc);

    if (response.statusCode == 200) {
      final Weather weather = Weather.fromJson(jsonDecode(response.body));
      return weather;
    } else {
      return null;
    }
  }

  Future<Weather?> getWeatherFromLocationUsingCoords(
      double lat, double lon) async {
    final response = await weatherAPI.fetchWeatherUsingCoords(lat, lon);

    if (response.statusCode == 200) {
      final Weather weather = Weather.fromJson(jsonDecode(response.body));
      return weather;
    } else {
      return null;
    }
  }

  Future<bool> checkIfLocationExistsInWeatherDatabase(
      double lat, double lon) async {
    final response = await weatherAPI.fetchWeatherUsingCoords(lat, lon);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<Locations?> getCitiesFromLocation(String loc) async {
    final response = await weatherAPI.fetchCities(loc);

    if (response.statusCode == 200) {
      if (jsonDecode(response.body) != null) {
        List<dynamic> jsonList = jsonDecode(response.body);
        var newJsonList = [];
        if (jsonList.isNotEmpty) {
          var jsonDynamicList = jsonDecode(response.body);
          List<String> list = jsonDynamicList.toString().split('}, {');
          for (int i = 0; i < list.length; i++) {
            bool existsInWeatherDatabase =
                await checkIfLocationExistsInWeatherDatabase(
                    jsonDynamicList[i]['lon'], jsonDynamicList[i]['lat']);
            if (existsInWeatherDatabase == true) {
              newJsonList.add(jsonDynamicList[i]);
            }
          }

          if (newJsonList.isNotEmpty) {
            final Locations cities = Locations.fromJson(newJsonList);
            return cities;
          }
        }
      }
    }
    return null;
  }
}
