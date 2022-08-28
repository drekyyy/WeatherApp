import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:weather_app/logic/bloc/search_bloc.dart';

import 'package:weather_app/logic/cubit/weather_cubit.dart';
import '../../logic/cubit/internet_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController = TextEditingController();

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
            Padding(
                padding: const EdgeInsets.only(top: 30),
                //child: Icon(Icons.sunny, size: 200, color: Colors.yellow)),
                child: Image.asset('assets/gifs/sun.gif',
                    height: MediaQuery.of(context).size.height * 0.4)),
            TextField(
              onChanged: (String value) {
                context
                    .read<SearchBloc>()
                    .add(SearchValueUpdated(value.trim()));
                print('value onchanged= $value');
                //return ListView();
              },
            ),
            BlocBuilder<SearchBloc, SearchState>(builder: ((context, state) {
              if (state is SearchValueStorage) {
                String? searchValue = state.searchValue;
                context
                    .read<SearchBloc>()
                    .add(SearchSuggestionsDisplayed(searchValue));
              }
              if (state is SearchSuggestions) {
                int length = state.locations!.length;
                return Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: length,
                        itemBuilder: (context, index) {
                          //print('index= $index');
                          //  Map<String, dynamic> map=state.cities[index];
                          return ListTile(
                              leading: Text(state.locations![index]['name']));
                        }));
              }
              return const SizedBox.shrink();
            }))
          ],
        ),
      ),
    );
  }
}

//             BlocBuilder<SearchBloc, SearchState>(
//               builder: (context, state) {
//                 if (state is SearchShowSuggestions) {
//                   int length = state.locations!.length;
//                   print('cities length in homes creen= $length');
//                   return Container(
//                       child: ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: length,
//                           itemBuilder: (context, index) {
//                             print('index= $index');
//                             //  Map<String, dynamic> map=state.cities[index];
//                             return ListTile(
//                                 leading: Text(state.locations![index]['name']));
//                           }));
//                 } else {
//context.read<SearchBloc>().add(ShowResult( _typeAheadController.toString().trim())),
// Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     Row(children: [
//                       Flexible(
//                           flex: 6,
//                           child: Container(
//                               transform:
//                                   Matrix4.translationValues(25.0, 0.0, 0.0),
//                               child: TextFormField(
//                                 controller: cityController,
//                                 decoration: const InputDecoration(
//                                   labelText: 'City name',
//                                 ),
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return 'Enter some text';
//                                   } else if (value.length < 2) {
//                                     return 'City name too short';
//                                   } else {
//                                     return null;
//                                   }
//                                 },
//                               ))),
//                       //const SizedBox(height: 50),
//                       Flexible(
//                           flex: 1,
//                           child: Container(
//                               padding: const EdgeInsets.all(0),
//                               transform:
//                                   Matrix4.translationValues(-25.0, 0.0, 0.0),
//                               child: FloatingActionButton(
//                                   onPressed: () {
//                                     context
//                                         .read<WeatherCubit>()
//                                         .emitWeatherInitial(); // emit to clear msg of weatherloadingfailed state
//                                     if (_formKey.currentState!.validate()) {
//                                       if (context.read<InternetCubit>().state
//                                           is InternetConnected) {
//                                         context
//                                             .read<WeatherCubit>()
//                                             .subscribeToWeatherStream(
//                                                 cityController.text.trim());
//                                       } else {
//                                         ScaffoldMessenger.of(context)
//                                             .showSnackBar(const SnackBar(
//                                                 content: Text(
//                                                     'No internet connection!')));
//                                       }
//                                     }
//                                   },
//                                   child: const Icon(
//                                       Icons.keyboard_arrow_right_rounded,
//                                       size: 40)))),
//                     ]),
//                     BlocBuilder<WeatherCubit, WeatherState>(
//                         builder: (context, state) {
//                       //print('state in homescreen=$state');
//                       if (state is WeatherLoadingFailed) {
//                         return Container(
//                             margin: const EdgeInsets.only(top: 5, left: 1),
//                             child: Align(
//                                 alignment: Alignment.bottomLeft,
//                                 child: Text('No such city exists',
//                                     style: TextStyle(
//                                         color: Colors.red.shade700,
//                                         fontSize: 13))));
//                       }
//                       return const SizedBox.shrink();
//                     }),
//                     FloatingActionButton(onPressed: () {
//                       //context.read<SearchBloc>().getCities('las');
//                       context.read<SearchBloc>().add(ShowResult('las'));
//                     }),
//                   ],
//                 )),
//             BlocBuilder<SearchBloc, SearchState>(
//               builder: (context, state) {
//                 if (state is SearchShowSuggestions) {
//                   int length = state.locations!.length;
//                   print('cities length in homes creen= $length');
//                   return Container(
//                       child: ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: length,
//                           itemBuilder: (context, index) {
//                             print('index= $index');
//                             //  Map<String, dynamic> map=state.cities[index];
//                             return ListTile(
//                                 leading: Text(state.locations![index]['name']));
//                           }));
//                 } else {
//                   return const Text('empty');
//                 }
//               },
//             )
