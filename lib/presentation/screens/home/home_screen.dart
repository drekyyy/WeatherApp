import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_app/logic/bloc/search_bloc.dart';
import 'package:weather_app/presentation/screens/home/components/search_results.dart';
import 'package:weather_app/presentation/screens/home/components/search_suggestions.dart';
import 'components/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text('Weather App', style: TextStyle(color: Colors.red))),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            BlocBuilder<SearchBloc, SearchState>(builder: (_, state) {
              if (state is SearchInitial) {
                return Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Image.asset('assets/gifs/sun.gif',
                        height: MediaQuery.of(context).size.height * 0.4));
              } else {
                return const SizedBox.shrink();
              }
            }),
            SearchBar(mounted: mounted),
            const SearchSuggestionsScreen(),
            const SearchResultsScreen()
          ],
        ),
      ),
    );
  }
}
