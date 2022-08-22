import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l/logic/cubit/weather_cubit.dart';
import 'package:l/presentation/screens/weather_screen.dart';

import 'home_screen.dart';
import 'loading_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    //print('wrapper here');
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        print('state= ${state}');
        if (state is WeatherLoading) {
          return const LoadingScreen();
        } else if (state is WeatherLoaded) {
          return const WeatherScreen();
        } else {
          return const HomeScreen();
        }
      },
    );
    //return const HomeScreen();
  }
}
