import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/logic/cubit/weather_cubit.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({Key? key}) : super(key: key);

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
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                              'Fetched on ${state.weather!.userDate} your local time.',
                              style: const TextStyle(color: Colors.grey)),
                          const SizedBox(height: 40),
                          Text(state.weather!.cityDate,
                              style: const TextStyle(
                                  fontSize: 17, color: Colors.orange)),
                          const SizedBox(height: 5),
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
                              SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: Image.asset(
                                    'assets/images/${state.weather!.icon}.png',
                                  )),
                              const SizedBox(width: 10),
                              Text(
                                '${state.weather!.temperature}°C',
                                style: const TextStyle(
                                    fontSize: 50, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Text(
                              '${state.weather!.temperatureMin}°C  -  ${state.weather!.temperatureMax}°C'),
                          const SizedBox(height: 20),
                          Text(state.weather!.weather,
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 20),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                  'Wind: ${state.weather!.windSpeed.toString()}m/s'),
                              const SizedBox(height: 5),
                              Text(
                                  'Pressure: ${state.weather!.pressure.toString()}hPa'),
                              const SizedBox(height: 5),
                              Text(
                                  'Humidity: ${state.weather!.humidity.toString()}%'),
                            ],
                          ),
                        ],
                      ));
                }
                return const Text(
                    'some error, WeatherState should always be WeatherLoaded on this screen but it isnt');
              },
            ),
            const SizedBox(height: 50),
            ElevatedButton(
                onPressed: () {
                  context.read<WeatherCubit>().unsubscribeWeatherStream();
                  //context.read<WeatherCubit>().emitWeatherInitial();
                },
                child: const Text('Check different city!'))
          ],
        )));
  }
}
