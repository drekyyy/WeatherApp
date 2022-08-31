import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/logic/bloc/search_bloc.dart';
import 'package:weather_app/logic/cubit/internet_cubit.dart';
import 'package:weather_app/logic/cubit/weather_cubit.dart';
import 'package:weather_app/presentation/screens/loading/loading_screen.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(builder: ((context, state) {
      var internetState = context.watch<InternetCubit>().state;

      if (state is SearchLoading && internetState is InternetConnected) {
        return const LoadingScreen(big: false, size: 40);
      }
      if (state is SearchResultsLoaded && internetState is InternetConnected) {
        if (state.locations == null) {
          if (state.weather == null) {
            return Column(children: const [
              SizedBox(height: 25),
              Center(child: Text('No results.'))
            ]);
          }
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
                  .subscribeToWeatherStreamByCity(state.weather!.city);
            },
          );
        } else {
          int length = state.locations!.length;
          return ListView.builder(
              shrinkWrap: true,
              itemCount: length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: SizedBox(
                      height: 50,
                      width: 50,
                      child: Image.asset(
                        'assets/images/country/${state.locations![index]['country'].toString().toLowerCase()}.png',
                        scale: 0.5,
                      )),
                  title: Text(
                      '${state.locations![index]['name']}, ${state.locations![index]['country']}'),
                  subtitle: Text(
                    state.locations![index]['state'] ?? '',
                    style: const TextStyle(fontSize: 11),
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    context
                        .read<WeatherCubit>()
                        .subscribeToWeatherStreamByCoords(
                            state.locations![index]['lat'],
                            state.locations![index]['lon']);
                  },
                );
              });
        }
      }
      return const SizedBox.shrink();
    }));
  }
}
