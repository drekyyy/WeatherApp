import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/data/city_model.dart';
import 'package:weather_app/data/weather_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final WeatherRepository repository;

  SearchBloc(this.repository) : super(SearchInitial()) {
    on<ShowResult>((event, emit) async {
      Cities? cities = await Future.value(getCities('las'));
      print('cities inside searchBloc event showresult= $cities');
      if (cities is Cities) {
        print('does it work???');
        emitSearchShow(cities);
      }
      // TODO: implement event handler
    });
  }
  Future<Cities?> getCities(String loc) async {
    final Cities? cities = await repository.getCitiesFromLocation(loc);
    return cities;
  }

  void emitSearchShow(Cities cities) => emit(SearchShow(cities));
}
