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
    //! this json is nested
    //?instead of creating models for every nest, ive decided to turn every nest into List<String>
    //then split the string of a given index from the list on ':' because it contains key and value
    //like a map yet it is a list. then access access the value which always has index 1, e.g {"temp", "267"}

    //example weather: [{id: 802, main: Clouds, description: scattered clouds, icon: 03n}]
    List<dynamic> weatherDynamicList = json['weather'];
    List<String> weatherList = weatherDynamicList.toString().split(',');

    //example main: {temp: 289.03, feels_like: 288.71, temp_min: 285.25, temp_max: 291.01, pressure: 1015, humidity: 78}
    var mainDynamicList = json['main'];
    List<String> mainList = mainDynamicList.toString().split(',');

    //example wind: {speed: 2.06, deg: 50}
    var windDynamicList = json['wind'];
    List<String> windList = (windDynamicList.toString()).split(',');
    //humidity is the last value of windList, when splitting by ':' it leaves '}' at the end,
    //so it needs below adjustments
    String humidityString = mainList[5].split(':')[1].trim();
    double humidityDouble =
        double.parse(humidityString.substring(0, humidityString.length - 1));

    double kelvin =
        272.15; // adjusting from kelvin to celcius (1kelvin=-272.15Celcius degree)
    return Weather(
        city: json['name'] ?? '',
        weather: weatherList[1].split(':')[1].trim(),
        icon: weatherList[3].split(':')[1].trim(),
        temperature:
            (((double.parse(mainList[0].split(':')[1].trim()) - kelvin) * 10)
                    .roundToDouble()) /
                10,
        temperatureMin:
            (((double.parse(mainList[2].split(':')[1].trim()) - kelvin) * 10)
                    .roundToDouble()) /
                10,
        temperatureMax:
            (((double.parse(mainList[3].split(':')[1].trim()) - kelvin) * 10)
                    .roundToDouble()) /
                10,
        pressure: double.parse(mainList[4].split(':')[1].trim()),
        windSpeed: double.parse(windList[0].split(':')[1].trim()),
        humidity: humidityDouble);
  }

  Weather copyWith({
    String? city,
    String? weather,
    String? icon,
    double? temperature,
    double? temperatureMin,
    double? temperatureMax,
    double? pressure,
    double? windSpeed,
    double? humidity,
  }) {
    return Weather(
      city: city ?? this.city,
      weather: weather ?? this.weather,
      icon: icon ?? this.icon,
      temperature: temperature ?? this.temperature,
      temperatureMin: temperatureMin ?? this.temperatureMin,
      temperatureMax: temperatureMax ?? this.temperatureMax,
      pressure: pressure ?? this.pressure,
      windSpeed: windSpeed ?? this.windSpeed,
      humidity: humidity ?? this.humidity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'city': city,
      'weather': weather,
      'icon': icon,
      'temperature': temperature,
      'temperatureMin': temperatureMin,
      'temperatureMax': temperatureMax,
      'pressure': pressure,
      'windSpeed': windSpeed,
      'humidity': humidity,
    };
  }

  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      city: map['city'] as String,
      weather: map['weather'] as String,
      icon: map['icon'] as String,
      temperature: map['temperature'] as double,
      temperatureMin: map['temperatureMin'] as double,
      temperatureMax: map['temperatureMax'] as double,
      pressure: map['pressure'] as double,
      windSpeed: map['windSpeed'] as double,
      humidity: map['humidity'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Weather(city: $city, weather: $weather, icon: $icon, temperature: $temperature, temperatureMin: $temperatureMin, temperatureMax: $temperatureMax, pressure: $pressure, windSpeed: $windSpeed, humidity: $humidity)';
  }

  @override
  bool operator ==(covariant Weather other) {
    if (identical(this, other)) return true;

    return other.city == city &&
        other.weather == weather &&
        other.icon == icon &&
        other.temperature == temperature &&
        other.temperatureMin == temperatureMin &&
        other.temperatureMax == temperatureMax &&
        other.pressure == pressure &&
        other.windSpeed == windSpeed &&
        other.humidity == humidity;
  }

  @override
  int get hashCode {
    return city.hashCode ^
        weather.hashCode ^
        icon.hashCode ^
        temperature.hashCode ^
        temperatureMin.hashCode ^
        temperatureMax.hashCode ^
        pressure.hashCode ^
        windSpeed.hashCode ^
        humidity.hashCode;
  }
}
