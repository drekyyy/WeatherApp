import 'package:http/http.dart' as http;

class WeatherDataProvider {
  //OpenWeatherMap.org API
  static const String _openWeaterMapAPIkey = "e8460431456b7c6714593735cbff6bfe";

  //current weather api
  Future<http.Response> fetchWeatherByCity(String city) {
    return http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$_openWeaterMapAPIkey'));
  }

  //current weather api
  Future<http.Response> fetchWeatherByCoords(double lat, double lon) {
    return http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$_openWeaterMapAPIkey'));
  }

  //geolocation api
  Future<http.Response> fetchCities(String city) {
    return http.get(Uri.parse(
        'http://api.openweathermap.org/geo/1.0/direct?q=$city&limit=10&appid=$_openWeaterMapAPIkey'));
  }
}
