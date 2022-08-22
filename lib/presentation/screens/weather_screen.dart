import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l/logic/cubit/weather_cubit.dart';

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
                  return Text(
                      'city name: ${state.weather!.city}, temperature: ${state.weather!.temperature.toString()}');
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
