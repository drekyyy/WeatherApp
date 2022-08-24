import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/weather_repository.dart';
import 'package:weather_app/logic/cubit/weather_cubit.dart';
import 'package:weather_app/presentation/screens/wrapper.dart';

import 'data/weather_data_provider.dart';
import 'logic/cubit/internet_cubit.dart';

void main() {
  WeatherDataProvider weatherAPI = WeatherDataProvider();
  runApp(MyApp(
    weatherRepository: WeatherRepository(weatherAPI),
    connectivity: Connectivity(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.weatherRepository, required this.connectivity})
      : super(key: key);
  final WeatherRepository weatherRepository;
  final Connectivity connectivity;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherCubit>(
          create: (context) => WeatherCubit(weatherRepository),
        ),
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity: connectivity),
        ),
      ],
      child: MaterialApp(
        title: 'Weather App',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: const Wrapper(),
      ),
    );
  }
}
