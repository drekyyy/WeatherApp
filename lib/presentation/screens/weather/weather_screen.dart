import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_app/logic/cubit/weather_cubit.dart';
import '../../../logic/cubit/internet_cubit.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('weather loaded')),
        ),
        body: Center(
            child: ListView(
          children: [
            BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoaded) {
                  var internetState = context.watch<InternetCubit>().state;
                  if (internetState is InternetDisconnected) {
                    context.read<WeatherCubit>().pauseWeatherStream();
                  }
                  if (internetState is InternetConnected) {
                    context.read<WeatherCubit>().resumeWeatherStream();
                  }
                  return Container(
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                              'Fetched on ${state.weather!.userDate} your local time.',
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 11)),
                          const SizedBox(height: 40),
                          Text(state.weather!.cityDate,
                              style: const TextStyle(
                                  fontSize: 17,
                                  color: Color.fromRGBO(239, 108, 0, 1))),
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
                                    'assets/images/weather/${state.weather!.icon}.png',
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
                          const SizedBox(height: 30),
                          Text(
                              'Feels like ${state.weather!.temperatureFeelsLike}°C, ${state.weather!.weather}.',
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 60),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Wind: ${state.weather!.windSpeed.toString()}m/s'),
                                    const SizedBox(height: 5),
                                    Text(
                                        'Humidity: ${state.weather!.humidity.toString()}%'),
                                  ]),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Pressure: ${state.weather!.pressure.toString()}hPa'),
                                    const SizedBox(height: 5),
                                    Text(
                                        'Visibility: ${state.weather!.visibility.toString()}km')
                                  ]),
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
            FloatingActionButton(
                onPressed: () {
                  context.read<WeatherCubit>().unsubscribeWeatherStream();
                },
                child: const Icon(Icons.keyboard_arrow_left_rounded, size: 40))
          ],
        )));
  }
}
