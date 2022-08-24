import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/weather_repository.dart';
import 'package:weather_app/logic/cubit/weather_cubit.dart';
import 'package:weather_app/presentation/screens/wrapper.dart';

import 'data/weather_data_provider.dart';

void main() {
  WeatherDataProvider weatherAPI = WeatherDataProvider();
  runApp(MyApp(
    weatherRepository: WeatherRepository(weatherAPI),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.weatherRepository}) : super(key: key);
  final WeatherRepository weatherRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(weatherRepository),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: const Wrapper(),
      ),
    );
  }
}
