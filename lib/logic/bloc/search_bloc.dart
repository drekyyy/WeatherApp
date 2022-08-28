// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/data/locations_model.dart';
import 'package:weather_app/data/weather_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final WeatherRepository repository;

  SearchBloc(this.repository) : super(SearchInitial()) {
    on<SearchValueUpdated>((event, emit) async {
      //checking if given seach value isnt empty
      if (event.value != null) {
        emitSearchWithValue(event.value);
        //checking if its longer than 2 and if it only contains alphabetic characters
        if (event.valueLength! > 2 &&
            event.value!.contains(RegExp('^[a-zA-Z]+'))) {
          Locations? locations = await Future.value(getCities(event.value!));
          if (locations is Locations) {
            emitSearchSuggestionsLoaded(locations);
          }
        }
      } else {
        emitSearchInitial();
      }
    });
  }
  Future<Locations?> getCities(String loc) async {
    final Locations? locations = await repository.getCitiesFromLocation(loc);
    return locations;
  }

  void emitSearchSuggestionsLoaded(Locations locations) =>
      // ignore: invalid_use_of_visible_for_testing_member
      emit(SearchSuggestionsLoaded(locations));
  //void emitSearchValidation(String message) => emit(SearchValidation(message));
  void emitSearchWithValue(String? searchValue) =>
      // ignore: invalid_use_of_visible_for_testing_member
      emit(SearchWithValue(searchValue));
  // ignore: invalid_use_of_visible_for_testing_member
  void emitSearchInitial() => emit(SearchInitial());
}
