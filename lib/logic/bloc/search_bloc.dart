import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/data/locations_model.dart';
import 'package:weather_app/data/weather_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final WeatherRepository repository;

  SearchBloc(this.repository) : super(SearchInitial()) {
    on<SearchSuggestionsDisplayed>((event, emit) async {
      if (event.loc != null) {
        // if (event.locLength! > 2) {
        Locations? locations = await Future.value(getCities(event.loc!));
        print('cities inside searchBloc event showresult= $locations');
        if (locations is Locations) {
          // print('does it work???');
          emitSearchSuggestions(locations);
        }
        // }
      } //else emitSearchShowValidation('Location field empty.');
    });
    on<SearchValueUpdated>((event, emit) async {
      await Future.delayed(const Duration(milliseconds: 500));
      emitSearchValueStorage(event.loc);
    });
  }
  Future<Locations?> getCities(String loc) async {
    final Locations? locations = await repository.getCitiesFromLocation(loc);
    return locations;
  }

  void emitSearchSuggestions(Locations locations) =>
      emit(SearchSuggestions(locations));
  void emitSearchValidation(String message) => emit(SearchValidation(message));
  void emitSearchValueStorage(String? searchValue) =>
      emit(SearchValueStorage(searchValue));
}
