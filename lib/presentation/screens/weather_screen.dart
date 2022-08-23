import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l/logic/cubit/weather_cubit.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  // String city;
  // String country;
  // String weather;
  // String icon;
  // double temperature;
  // double temperatureMin;
  // double temperatureMax;
  // double pressure;
  // double windSpeed;
  // double humidity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('weather loaded')),
        ),
        body: Center(
            child: Column(
          children: [
            BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoaded) {
                  // return Text(
                  //   'city name: ${state.weather!.city}, temperature: ${state.weather!.temperature.toString()});
                  return Column(
                    children: [
                      Row(
                        children: [
                          Text(
                              '${state.weather!.city}, ${state.weather!.country}'),
                          const Icon(Icons.cloud)
                        ],
                      ),
                      const SizedBox(height: 40),
                      Text(state.weather!.weather)
                    ],
                  );
                }
                return const Text(
                    'some error, WeatherState should always be WeatherLoaded on this screen but it isnt?');
              },
            ),
            const SizedBox(height: 50),
            ElevatedButton(
                onPressed: () {
                  context.read<WeatherCubit>().emitWeatherInitial();
                },
                child: const Text('Sprawdź inne miasto!'))
          ],
        )));
  }
}
