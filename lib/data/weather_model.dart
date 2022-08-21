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




// class Weather {
//   String city;
//   String weather;
//   String icon;
//   double temperature;
//   double temperatureMin;
//   double temperatureMax;
//   double pressure;
//   double windSpeed;
//   double humidity;

//   Weather({
//     required this.city,
//     required this.weather,
//     required this.icon,
//     required this.temperature,
//     required this.temperatureMin,
//     required this.temperatureMax,
//     required this.pressure,
//     required this.windSpeed,
//     required this.humidity,
//   });

//   factory Weather.fromJson(Map<String, dynamic> json) {
//     return Weather(
//       city: json['name'],
//       weather: json['weather.main'],
//       icon: json['weather.icon'],
//       temperature: json['main.temp'],
//       temperatureMin: json['main.temp_min'],
//       temperatureMax: json['main.temp_max'],
//       pressure: json['main.pressure'],
//       windSpeed: json['wind.speed'],
//       humidity: json['main.humidity'],
//     );
//   }
// }
