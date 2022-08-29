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
    TextEditingController textController = TextEditingController();
    return Container(
        margin: const EdgeInsets.only(left: 15, right: 15),
        child: Column(children: [
          TextField(
            controller: textController,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    color: Colors.orange[600],
                    onPressed: () {
                      var internetState = context.read<InternetCubit>().state;

                      if (internetState is InternetConnected) {
                        if (textController.text.length > 2) {
                          context
                              .read<WeatherCubit>()
                              .subscribeToWeatherStreamUsingCityName(
                                  textController.text.trim());
                        } else {
                          context
                              .read<WeatherCubit>()
                              .emitWeatherValidationFailed(
                                  'City name too short!');
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('No internet connection!')));
                      }
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_right,
                      size: 30,
                    ))),
            onChanged: (String value) async {
              //need to make sure that widget is mounted if we want to use context after async
              var weatherState = context.read<WeatherCubit>().state;

              if (weatherState is WeatherValidationFailed) {
                context.read<WeatherCubit>().emitWeatherInitial();
              }

              if (value.isNotEmpty &&
                  context.read<InternetCubit>().state is InternetConnected) {
                context
                    .read<SearchBloc>()
                    .add(SearchValueUpdated(value.trim()));
              }

              // if search value is empty for 10s, go back to initial state (displays sun gif).
              // the timer doesnt reset after onchange is called again, so if u typed something and happened to
              // delete it around 5s, u might instantly go back to sun gif screen
              if (value.isEmpty) {
                context.read<SearchBloc>().add(const SearchValueUpdated(null));
              }
            },
          ),
          BlocBuilder<WeatherCubit, WeatherState>(
            builder: (context, state) {
              if (state is WeatherValidationFailed) {
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
