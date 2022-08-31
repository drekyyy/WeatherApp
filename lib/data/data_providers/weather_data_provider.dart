import 'package:http/http.dart' as http;

class WeatherDataProvider {
  static const String _openWeaterMapAPIkey = "e8460431456b7c6714593735cbff6bfe";

  Future<http.Response> fetchWeatherByCity(String city) {
    //current weather api
    return http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$_openWeaterMapAPIkey'));
  }

  Future<http.Response> fetchWeatherByCoords(double lat, double lon) {
    //current weather api
    return http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$_openWeaterMapAPIkey'));
  }

  Future<http.Response> fetchCities(String city) {
    //geolocation api
    return http.get(Uri.parse(
        'http://api.openweathermap.org/geo/1.0/direct?q=$city&limit=10&appid=$_openWeaterMapAPIkey'));
  }
}
