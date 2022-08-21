import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:l/data/weather_repository.dart';

import '../../data/weather_model.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this.repository) : super(WeatherLoading());
  final WeatherRepository repository;

  void getWeather(String loc) async {
    emitWeatherLoading();
    final Weather weather = await repository.getWeatherFromLocation(loc);
    emitWeatherLoaded(weather);
  }

  void emitWeatherLoaded(Weather weather) => emit(WeatherLoaded(weather));
  void emitWeatherLoading() => emit(WeatherLoading());
}
