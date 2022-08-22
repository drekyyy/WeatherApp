part of 'weather_cubit.dart';

class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

//maybe go back to WeatherInitial. loading doesnt make sense at start since the weather is
// queried after some time (when someone types data). use WeatgerLoading when we loading the weather screen
class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather? weather;
  const WeatherLoaded(this.weather);
}

class WeatherLoadingFailed extends WeatherState {}
