// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/data/models/locations_model.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/data/repositories/weather_repository.dart';

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
          Weather? weather =
              await Future.value(getLocationSuggestion(event.value!));
          if (weather is Weather) {
            emitSearchSuggestionsLoaded(weather);
          }
        }
      } else {
        emitSearchInitial();
      }
    });
    on<SearchResultsRequested>((event, emit) async {
      emitSearchLoading();
      Locations? locations = await Future.value(getCities(event.value));

      emitSearchResultsLoaded(locations);
    });
  }
  Future<Weather?> getLocationSuggestion(String loc) async {
    final Weather? weather =
        await repository.getWeatherFromLocationUsingCityName(loc);
    return weather;
  }

  Future<Locations?> getCities(String loc) async {
    final Locations? locations = await repository.getCitiesFromLocation(loc);
    return locations;
  }

  void emitSearchSuggestionsLoaded(Weather location) =>
      emit(SearchSuggestionsLoaded(location));
  // ignore: invalid_use_of_visible_for_testing_memSearchSuggestionLoadeduggestionLoaded(locations));
  void emitSearchWithValue(String? searchValue) =>
      emit(SearchWithValue(searchValue));
  void emitSearchInitial() => emit(SearchInitial());
  void emitSearchResultsLoaded(Locations? locations) =>
      emit(SearchResultsLoaded(locations));
  void emitSearchLoading() => emit(SearchLoading());
}
