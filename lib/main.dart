import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'package:weather_app/data/data_providers/weather_data_provider.dart';
import 'package:weather_app/data/repositories/weather_repository.dart';
import 'package:weather_app/logic/cubit/weather_cubit.dart';
import 'package:weather_app/logic/observer/app_bloc_observer.dart';
import 'package:weather_app/presentation/screens/wrapper.dart';
import 'package:weather_app/presentation/theme/custom_theme.dart';
import 'logic/bloc/search_bloc.dart';
import 'logic/cubit/internet_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarDividerColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  Bloc.observer = AppBlocObserver();
  WeatherDataProvider weatherAPI = WeatherDataProvider();

  HydratedBlocOverrides.runZoned(
      () => runApp(MyApp(
            weatherRepository: WeatherRepository(weatherAPI),
            connectivity: Connectivity(),
          )),
      storage: storage,
      blocObserver: AppBlocObserver());
}

class MyApp extends StatelessWidget {
  const MyApp(
      {Key? key, required this.weatherRepository, required this.connectivity})
      : super(key: key);
  final WeatherRepository weatherRepository;
  final Connectivity connectivity;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherCubit>(
          create: (context) => WeatherCubit(weatherRepository),
        ),
        BlocProvider<InternetCubit>(
          lazy: false,
          create: (context) => InternetCubit(connectivity: connectivity),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(weatherRepository),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        theme: CustomTheme.darkTheme,
        home: const Wrapper(),
      ),
    );
  }
}
