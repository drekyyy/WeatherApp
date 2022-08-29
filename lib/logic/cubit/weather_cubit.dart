import 'dart:async';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/data/repositories/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(
    this._repository,
  ) : super(WeatherInitial());
  final WeatherRepository _repository;
  StreamSubscription? _weatherStreamSubscription;

  Stream<dynamic>? _getStreamOfWeatherUsingCityName(String loc, int sec) {
    return Stream.periodic(
      Duration(seconds: sec),
      (int count) {
        return _repository.getWeatherFromLocationUsingCityName(loc);
      },
    );
  }

  Stream<dynamic>? _getStreamOfWeatherUsingCoords(
      double lat, double lon, int sec) {
    return Stream.periodic(
      Duration(seconds: sec),
      (int count) {
        return _repository.getWeatherFromLocationUsingCoords(lat, lon);
      },
    );
  }

  void subscribeToWeatherStreamUsingCityName(String loc) async {
    _isStreamPaused = false;
    final controller = StreamController(
      // ignore: avoid_print
      onCancel: () => print('Cancelled'),
      // ignore: avoid_print
      onListen: () => print('Listens'),
    );
    //get weather instantly (once), so user isnt stuck in loading screen waiting for the
    //stream data which can take a bit of time
    _getWeatherUsingCityName(loc);

    //update weather every
    int updateEveryThisManySeconds = 60;
    controller.addStream(
        _getStreamOfWeatherUsingCityName(loc, updateEveryThisManySeconds)!);
    _weatherStreamSubscription = controller.stream.listen((event) async {
      Weather? weather = await Future.value(event);
      if (weather is Weather) {
        emitWeatherLoaded(weather);
      }
    });
  }

  void subscribeToWeatherStreamUsingCoords(double lat, double lon) async {
    _isStreamPaused = false;
    final controller = StreamController(
      // ignore: avoid_print
      onCancel: () => print('Cancelled'),
      // ignore: avoid_print
      onListen: () => print('Listens'),
    );
    //get weather instantly (once), so user isnt stuck in loading screen waiting for the
    //stream data which can take a bit of time
    _getWeatherUsingCoords(lat, lon);

    //update weather every
    int updateEveryThisManySeconds = 5;
    controller.addStream(
        _getStreamOfWeatherUsingCoords(lat, lon, updateEveryThisManySeconds)!);
    _weatherStreamSubscription = controller.stream.listen((event) async {
      Weather? weather = await Future.value(event);
      if (weather is Weather) {
        emitWeatherLoaded(weather);
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

  void _getWeatherUsingCityName(String loc) async {
    emitWeatherLoading();
    final Weather? weather =
        await _repository.getWeatherFromLocationUsingCityName(loc);
    if (weather != null) {
      emitWeatherLoaded(weather);
    } else {
      emitWeatherValidationFailed('No such city exists!');
    }
  }

  void _getWeatherUsingCoords(double lat, double lon) async {
    emitWeatherLoading();
    final Weather? weather =
        await _repository.getWeatherFromLocationUsingCoords(lat, lon);
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
