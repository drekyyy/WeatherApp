// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'weather_cubit.dart';

class WeatherState extends Equatable {
  const WeatherState();
  Map<String, dynamic> toMap() {
    return {};
  }

  factory WeatherState.fromMap(Map<String, dynamic> map) {
    return const WeatherState();
  }

  String toJson() => json.encode(toMap());

  factory WeatherState.fromJson(String source) =>
      WeatherLoaded.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather? weather;
  const WeatherLoaded(this.weather);
  @override
  List<Object> get props => [weather!];

  @override
  String toString() => 'WeatherLoaded(weather: $weather)';

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'weather': weather?.toMap(),
    };
  }

  factory WeatherLoaded.fromMap(Map<String, dynamic> map) {
    return WeatherLoaded(
      map['weather'] != null
          ? Weather.fromMap(map['weather'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory WeatherLoaded.fromJson(String source) =>
      WeatherLoaded.fromMap(json.decode(source) as Map<String, dynamic>);
}

class WeatherValidationFailed extends WeatherState {
  final String message;
  const WeatherValidationFailed(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'WeatherValidationFailed(message: $message)';
}
