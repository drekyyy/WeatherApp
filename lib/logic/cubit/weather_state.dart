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
}

class WeatherLoadingFailed extends WeatherState {}
