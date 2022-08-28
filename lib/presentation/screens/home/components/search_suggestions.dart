import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/logic/bloc/search_bloc.dart';
import 'package:weather_app/logic/cubit/internet_cubit.dart';
import 'package:weather_app/logic/cubit/weather_cubit.dart';

class SearchSuggestions extends StatelessWidget {
  const SearchSuggestions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(builder: ((context, state) {
      var internetState = context.watch<InternetCubit>().state;
      if (state is SearchWithValue && internetState is InternetConnected) {
        String? searchValue = state.value;
      }

      if (state is SearchSuggestionsLoaded &&
          internetState is InternetConnected) {
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
                title: Text(state.locations![index]['name']),
                subtitle: Text(
                  state.locations![index]['state'] ?? '',
                  style: const TextStyle(fontSize: 11),
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  context.read<WeatherCubit>().subscribeToWeatherStream('');
                },
              );
            });
      }
      return const SizedBox.shrink();
    }));
  }
}