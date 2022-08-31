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

    if (response.statusCode == 200) {
      final Weather weather = Weather.fromJson(jsonDecode(response.body));
      return weather;
    } else {
      return null;
    }
  }

  // geolocation api (fetchCities()) returns different city name from current weather api (fetchWeather())
  // and we prefer weather api city name, because thats how its gonna be displayed on weather screen
  // therefore city names shown in results should match those displayed on weather screen
  Future<String> getActualCityName(double lat, double lon) async {
    final response = await weatherAPI.fetchWeatherByCoords(lat, lon);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['name'];
    } else {
      return '';
    }
  }

  Future<Locations?> getCitiesFromLocation(String loc) async {
    final response = await weatherAPI.fetchCities(loc);

    if (response.statusCode == 200) {
      if (jsonDecode(response.body) != null) {
        List<dynamic> json = jsonDecode(response.body);
        var newJson = [];
        if (json.isNotEmpty) {
          List<String> list = json.toString().split('}, {');
          for (int i = 0; i < list.length; i++) {
            String actualCityName =
                await getActualCityName(json[i]['lat'], json[i]['lon']);

            if (actualCityName.isNotEmpty &&
                actualCityName.toLowerCase().contains(loc.toLowerCase())) {
              json[i]['name'] = actualCityName;
              newJson.add(json[i]);
            }
          }

          if (newJson.isNotEmpty) {
            final Locations cities = Locations.fromJson(newJson);
            return cities;
          }
        }
      }
    }
    return null;
  }
}
