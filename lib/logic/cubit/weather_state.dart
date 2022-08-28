// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'weather_cubit.dart';

class WeatherState extends Equatable {
  const WeatherState();

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
}

class WeatherValidationFailed extends WeatherState {
  final String message;
  const WeatherValidationFailed(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'WeatherValidationFailed(message: $message)';
}
