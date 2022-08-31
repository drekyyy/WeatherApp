import 'dart:async';
import 'dart:convert';

import 'package:weather_app/data/data_providers/weather_data_provider.dart';
import 'package:weather_app/data/models/locations_model.dart';
import 'package:weather_app/data/models/weather_model.dart';

class WeatherRepository {
  final WeatherDataProvider weatherAPI;

  WeatherRepository(this.weatherAPI);

  Future<Weather?> getWeatherByCity(String loc) async {
    final response = await weatherAPI.fetchWeatherByCity(loc);

    if (response.statusCode == 200) {
      final Weather weather = Weather.fromJson(jsonDecode(response.body));
      return weather;
    } else {
      return null;
    }
  }

  Future<Weather?> getWeatherByCoords(double lat, double lon) async {
    final response = await weatherAPI.fetchWeatherByCoords(lat, lon);
    print('lat=$lat, lon=$lon ');
    if (response.statusCode == 200) {
      final Weather weather = Weather.fromJson(jsonDecode(response.body));
      return weather;
    } else {
      return null;
    }
  }

  Future<String> locationExistsInWeatherDatabase(double lat, double lon) async {
    final response = await weatherAPI.fetchWeatherByCoords(lat, lon);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['name'];
    } else {
      return '';
    }
  }

  Future<Locations?> getCitiesFromLocation(String loc) async {
    final response = await weatherAPI.fetchCities(loc);
    print('jsonDecode(response.body)=${jsonDecode(response.body)}');
    if (response.statusCode == 200) {
      if (jsonDecode(response.body) != null) {
        List<dynamic> jsonList = jsonDecode(response.body);
        var newJsonList = [];
        if (jsonList.isNotEmpty) {
          List<String> list = jsonList.toString().split('}, {');
          for (int i = 0; i < list.length; i++) {
            String actualCityName = await locationExistsInWeatherDatabase(
                jsonList[i]['lat'], jsonList[i]['lon']);

            if (actualCityName.isNotEmpty &&
                actualCityName.toLowerCase().contains(loc.toLowerCase())) {
              jsonList[i]['name'] = actualCityName;
              newJsonList.add(jsonList[i]);
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
