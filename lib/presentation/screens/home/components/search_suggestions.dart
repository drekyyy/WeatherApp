import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/logic/bloc/search_bloc.dart';
import 'package:weather_app/logic/cubit/internet_cubit.dart';
import 'package:weather_app/logic/cubit/weather_cubit.dart';

class SearchSuggestionsScreen extends StatelessWidget {
  const SearchSuggestionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(builder: ((context, state) {
      var internetState = context.watch<InternetCubit>().state;

      if (state is SearchSuggestionsLoaded &&
          internetState is InternetConnected) {
        return ListTile(
          leading: SizedBox(
              height: 50,
              width: 50,
              child: Image.asset(
                'assets/images/country/${state.weather!.country.toString().toLowerCase()}.png',
                scale: 0.5,
              )),
          title: Text('${state.weather!.city}, ${state.weather!.country}'),
          onTap: () {
            context
                .read<WeatherCubit>()
                .subscribeToWeatherStreamUsingCityName(state.weather!.city);
          },
        );
      }
      return const SizedBox.shrink();
    }));
  }
}
