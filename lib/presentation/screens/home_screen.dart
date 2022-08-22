import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l/data/weather_model.dart';
import 'package:l/data/weather_repository.dart';

import '../../logic/cubit/weather_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('home sceen')),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Icon(Icons.sunny, size: 200, color: Colors.yellow)),
            const SizedBox(height: 40),
            Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: cityController,
                          decoration: const InputDecoration(
                              labelText: 'City name',
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, color: Colors.orange))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter some text';
                            } else if (value.length < 2) {
                              return 'City name too short';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                print('miasto= ${cityController.text.trim()}');
                                context
                                    .read<WeatherCubit>()
                                    .getWeather(cityController.text.trim());
                              }
                            },
                            child: const Icon(Icons.check))
                      ],
                    ))),
            // BlocBuilder<WeatherCubit, WeatherState>(builder: (context, state) {
            //   //ten blocbuilder przesunac na sama gore,
            //   //jesli state is WeatherInitial, to pokazujemy ekran weatherApp domyslny, z polem do podania miasta itp
            //   //jesli state is WeatherLoading to pokazujemy loading
            //   //jesli state is weatherLoaded to pokazujemy ekran pieknie ukazujacy pogode

            //   if (state is WeatherLoaded) {
            //     return Text(
            //         'city name: ${state.weather!.city}, temperature: ${state.weather!.temperature.toString()}');
            //   }
            //   if (state is WeatherLoading) {
            //     return Text('Loading...');
            //   } else {
            //     return Text('Something is up? neither loading nor loaded');
            //   }
            // }
          ],
        ),
      ),
    );
  }
}
