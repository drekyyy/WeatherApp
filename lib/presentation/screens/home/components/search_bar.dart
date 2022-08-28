import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_app/logic/bloc/search_bloc.dart';
import 'package:weather_app/logic/cubit/internet_cubit.dart';
import 'package:weather_app/logic/cubit/weather_cubit.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    required this.mounted,
  }) : super(key: key);

  final bool mounted;

  @override
  Widget build(BuildContext context) {
    String val = '';
    return Container(
        margin: const EdgeInsets.only(left: 15, right: 15),
        child: Column(children: [
          TextField(
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    color: Colors.orange[600],
                    onPressed: () {
                      if (val.length > 2) {
                        var internetState = context.read<InternetCubit>().state;
                        if (internetState is InternetConnected) {
                          context
                              .read<WeatherCubit>()
                              .subscribeToWeatherStream(val.trim());
                        }
                      } else {
                        context
                            .read<WeatherCubit>()
                            .emitWeatherValidationFailed(
                                'City name too short!');
                      }
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_right,
                      size: 30,
                    ))),
            onChanged: (String value) async {
              val = value;
              await Future.delayed(const Duration(milliseconds: 100));

              if (!mounted) {
                return;
              } //need to make sure that widget is mounted if we want to use context after async
              var weatherState = context.read<WeatherCubit>().state;
              print('weatherState = $weatherState');
              if (weatherState is WeatherValidationFailed) {
                context.read<WeatherCubit>().emitWeatherInitial();
              }
              if (value.isNotEmpty) {
                context
                    .read<SearchBloc>()
                    .add(SearchValueUpdated(value.trim()));
              } else {
                context.read<SearchBloc>().add(const SearchValueUpdated(null));
              }
            },
          ),
          BlocBuilder<WeatherCubit, WeatherState>(
            builder: (context, state) {
              if (state is WeatherValidationFailed) {
                print(state);
                return Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(state.message,
                        style: const TextStyle(color: Colors.red)));
              } else {
                return const SizedBox.shrink();
              }
            },
          )
        ]));
  }
}
