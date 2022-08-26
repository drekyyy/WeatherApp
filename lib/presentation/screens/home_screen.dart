import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_app/logic/cubit/weather_cubit.dart';
import '../../logic/cubit/internet_cubit.dart';

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
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter some text';
                            } else if (value.length < 2) {
                              return 'City name too short';
                            } else {
                              return null;
                            }
                          },
                        ),
                        BlocBuilder<WeatherCubit, WeatherState>(
                            builder: (context, state) {
                          //print('state in homescreen=$state');
                          if (state is WeatherLoadingFailed) {
                            return Container(
                                margin: const EdgeInsets.only(top: 5, left: 1),
                                child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text('No such city exists',
                                        style: TextStyle(
                                            color: Colors.red.shade700,
                                            fontSize: 13))));
                          }
                          return const SizedBox.shrink();
                        }),
                        const SizedBox(height: 50),
                        FloatingActionButton(
                            onPressed: () {
                              context.read<WeatherCubit>().emitWeatherInitial();
                              if (_formKey.currentState!.validate()) {
                                if (context.read<InternetCubit>().state
                                    is InternetConnected) {
                                  context
                                      .read<WeatherCubit>()
                                      .subscribeToWeatherStream(
                                          cityController.text.trim(), context);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('No internet connection!')));
                                }
                              }
                            },
                            child: const Icon(
                                Icons.keyboard_arrow_right_rounded,
                                size: 40))
                      ],
                    ))),
          ],
        ),
      ),
    );
  }
}
