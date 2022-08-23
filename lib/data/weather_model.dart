import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Weather {
  String date;
  String city;
  String country;
  String weather;
  String icon;
  double temperature;
  double temperatureMin;
  double temperatureMax;
  double pressure;
  double windSpeed;
  double humidity;

  Weather({
    required this.date,
    required this.city,
    required this.country,
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
    //?instead of creating models for every nest, ive decided to create a function where
    //?every nested json is a List<dynamic> which u turn into List<String> by first splitting it on ','
    //example nested json of weather: [{id: 802, main: Clouds, description: scattered clouds, icon: 03n}]
    //?then split every List<String> on ':' e.g. {temp: 267} into "{temp" and "267}"
    //?to get a String containing either key or value

    //example nested json of main: {temp: 289.03, feels_like: 288.71, temp_min: 285.25, temp_max: 291.01, pressure: 1015, humidity: 78}
    //example nested json of wind: {speed: 2.06, deg: 50}

    double roundToXth(double value, double x) {
      //also converting kelvin to Celcius, set kelvin to 0 if u dont want to convert
      double kelvin = 272.15;
      return ((value - kelvin) * x).roundToDouble() / x;
    }

    String getValueFromNestedJson(var jsonDynamicList, String wantedKey) {
      List<String> list = jsonDynamicList.toString().split(',');
      for (int i = 0; i < list.length; i++) {
        String key = list[i].split(':')[0].trim();
        String value = list[i].split(':')[1].trim();
        if (key[0] == '{') {
          key = key.substring(1);
        }
        if (value[value.length - 1] == '}') {
          value = value.substring(0, value.length - 1);
        }
        if (key == wantedKey) {
          return value;
        }
      }
      return '0';
    }

    // date with time zone of a place must be done
    String getDate() {
      DateTime now = DateTime.now();
      String month = now.month.toString();
      String day = now.day.toString();
      String minute = now.minute.toString();
      int monthInt = now.month;
      int dayInt = now.day;
      int minuteInt = now.minute;
      if (monthInt < 10) {
        month = "0$month";
      }
      if (dayInt < 10) {
        day = "0$day";
      }
      if (minuteInt < 10) {
        minute = "0$minute";
      }
      return '$month/$day  ${now.hour}:$minute';
    }

    return Weather(
      date: getDate(),
      city: json['name'],
      country: getValueFromNestedJson(json['sys'], 'country'),
      weather: getValueFromNestedJson(json['weather'], 'description'),
      icon: getValueFromNestedJson(json['weather'], 'icon'),
      temperature: roundToXth(
          double.parse(getValueFromNestedJson(json['main'], 'temp')), 10),
      temperatureMin: roundToXth(
          double.parse(getValueFromNestedJson(json['main'], 'temp_min')), 10),
      temperatureMax: roundToXth(
          double.parse(getValueFromNestedJson(json['main'], 'temp_max')), 10),
      pressure: double.parse(getValueFromNestedJson(json['main'], 'pressure')),
      windSpeed: double.parse(getValueFromNestedJson(json['wind'], 'speed')),
      humidity: double.parse(getValueFromNestedJson(json['main'], 'humidity')),
    );
  }

  Weather copyWith({
    String? date,
    String? city,
    String? country,
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
      date: date ?? this.date,
      city: city ?? this.city,
      country: country ?? this.country,
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
      'date': date,
      'city': city,
      'country': country,
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
      date: map['date'] as String,
      city: map['city'] as String,
      country: map['country'] as String,
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
    return 'Weather(date: $date, city: $city, country: $country, weather: $weather, icon: $icon, temperature: $temperature, temperatureMin: $temperatureMin, temperatureMax: $temperatureMax, pressure: $pressure, windSpeed: $windSpeed, humidity: $humidity)';
  }

  @override
  bool operator ==(covariant Weather other) {
    if (identical(this, other)) return true;

    return other.date == date &&
        other.city == city &&
        other.country == country &&
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
    return date.hashCode ^
        city.hashCode ^
        country.hashCode ^
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
