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
                  return Container(
                      margin: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                              'fetched at: ${state.weather!.date} your local time',
                              style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 20),
                          Center(
                              child: Text(
                            '${state.weather!.city}, ${state.weather!.country}',
                            style: const TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          )),
                          const SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.cloud, size: 40),
                              const SizedBox(width: 10),
                              Text(
                                '${state.weather!.temperature}°C',
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Text(
                              '${state.weather!.temperatureMin}°C  -  ${state.weather!.temperatureMax}°C'),
                          const SizedBox(height: 20),
                          Text(state.weather!.weather,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 20),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                  'Wind: ${state.weather!.windSpeed.toString()}m/s'),
                              Text(
                                  'Pressure: ${state.weather!.pressure.toString()}hPa'),
                              Text(
                                  'Humidity: ${state.weather!.humidity.toString()}'),
                              //Text('asd: ${state.weather!.pressure.toString()}')
                            ],
                          ),
                        ],
                      ));
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
