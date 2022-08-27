import 'package:http/http.dart' as http;

class WeatherDataProvider {
  static const String _weatherAPIkey = "e8460431456b7c6714593735cbff6bfe";

  Future<http.Response> fetchWeather(String city) {
    return http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$_weatherAPIkey'));
  }

  Future<http.Response> fetchCities(String city) {
    return http.get(Uri.parse(
        'http://api.openweathermap.org/geo/1.0/direct?q=$city&limit=5&appid=$_weatherAPIkey'));
  }
}


//https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
//https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}