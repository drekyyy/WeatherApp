import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_app/data/weather_model.dart';
import 'package:weather_app/data/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(
    this._repository,
  ) : super(WeatherInitial());
  final WeatherRepository _repository;
  StreamSubscription? _weatherStreamSubscription;

  Stream<dynamic>? _getStreamOfWeather(String loc, int sec) {
    return Stream.periodic(
      Duration(seconds: sec),
      (int count) {
        return _repository.getWeatherFromLocation(loc);
      },
    );
  }

  void subscribeToWeatherStream(String loc) async {
    _isStreamPaused = false;
    final controller = StreamController(
      // ignore: avoid_print
      onCancel: () => print('Cancelled'),
      // ignore: avoid_print
      onListen: () => print('Listens'),
    );
    //get weather instantly (once), so user isnt stuck in loading screen waiting for the
    //stream data which can take a bit of time
    _getWeather(loc);

    //update weather every
    int updateEveryThisManySeconds = 60;
    controller.addStream(_getStreamOfWeather(loc, updateEveryThisManySeconds)!);
    _weatherStreamSubscription = controller.stream.listen((event) async {
      Weather? weather = await Future.value(event);
      if (weather is Weather) {
        emitWeatherLoaded(weather);
      } else {
        //technically this state will never occur because we called getWeather()
        //before which checks for this rule (it emits when the given city doesnt exist)
        emitWeatherValidationFailed('No such city exists!');
      }
    });
  }

  bool? _isStreamPaused;
  void pauseWeatherStream() {
    if (_isStreamPaused == false) {
      _weatherStreamSubscription?.pause();
      _isStreamPaused = true;
    }
  }

  void resumeWeatherStream() async {
    await Future.delayed(const Duration(seconds: 5));
    if (_isStreamPaused == true) {
      _weatherStreamSubscription?.resume();
      _isStreamPaused = false;
    }
  }

  void unsubscribeWeatherStream() async {
    if (_weatherStreamSubscription != null) {
      await _weatherStreamSubscription!.cancel();
      emitWeatherInitial();
    }
  }

  void _getWeather(String loc) async {
    emitWeatherLoading();
    final Weather? weather = await _repository.getWeatherFromLocation(loc);
    if (weather != null) {
      emitWeatherLoaded(weather);
    } else {
      emitWeatherValidationFailed('No such city exists!');
    }
  }

  void emitWeatherLoaded(Weather weather) => emit(WeatherLoaded(weather));
  void emitWeatherLoading() => emit(WeatherLoading());
  void emitWeatherInitial() => emit(WeatherInitial());
  void emitWeatherValidationFailed(String message) =>
      emit(WeatherValidationFailed(message));
}
