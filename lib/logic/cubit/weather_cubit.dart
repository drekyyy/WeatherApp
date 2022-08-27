import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/city_model.dart';
import 'package:weather_app/data/weather_model.dart';
import 'package:weather_app/data/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(
    this.repository,
  ) : super(WeatherInitial());
  final WeatherRepository repository;
  StreamSubscription? weatherStreamSubscription;

  Stream<dynamic>? getStreamOfWeather(String loc, int sec) {
    return Stream.periodic(
      Duration(seconds: sec),
      (int count) {
        return repository.getWeatherFromLocation(loc);
      },
    );
  }

  void subscribeToWeatherStream(String loc) async {
    isStreamPaused = false;
    final _controller = StreamController(
      onCancel: () => print('Cancelled'),
      onListen: () => print('Listens'),
    );
    //emitWeatherLoading();
    //get weather instantly (once), so user isnt stuck in loading screen waiting for the
    //stream data which can take a bit of time
    getWeather(loc);

    //update weather every
    int updateEveryThisManySeconds = 60;
    _controller.addStream(getStreamOfWeather(loc, updateEveryThisManySeconds)!);
    weatherStreamSubscription = _controller.stream.listen((event) async {
      Weather? weather = await Future.value(event);
      if (weather is Weather) {
        emitWeatherLoaded(weather);
      } else {
        //technically this state will never occur because we called getWeather()
        //before which checks for this rule (it emits when the given city doesnt exist)
        emitWeatherLoadingFailed();
      }
    });
  }

  bool? isStreamPaused;
  void pauseWeatherStream() {
    if (isStreamPaused == false) {
      weatherStreamSubscription?.pause();
      isStreamPaused = true;
    }
  }

  void resumeWeatherStream() async {
    await Future.delayed(const Duration(seconds: 5));
    if (isStreamPaused == true) {
      weatherStreamSubscription?.resume();
      isStreamPaused = false;
    }
  }

  void unsubscribeWeatherStream() async {
    if (weatherStreamSubscription != null) {
      await weatherStreamSubscription!.cancel();
      emitWeatherInitial();
    }
  }

  void getWeather(String loc) async {
    emitWeatherLoading();
    final Weather? weather = await repository.getWeatherFromLocation(loc);
    print('weather= $weather');
    if (weather != null) {
      emitWeatherLoaded(weather);
    } else {
      emitWeatherLoadingFailed();
    }
  }

  void emitWeatherLoaded(Weather weather) => emit(WeatherLoaded(weather));
  void emitWeatherLoading() => emit(WeatherLoading());
  void emitWeatherInitial() => emit(WeatherInitial());
  void emitWeatherLoadingFailed() => emit(WeatherLoadingFailed());
}
