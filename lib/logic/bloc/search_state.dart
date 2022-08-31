// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchWithValue extends SearchState {
  final String? value;
  const SearchWithValue(this.value);
  @override
  List<Object> get props => [value!];

  @override
  String toString() => 'SearchWithValue(value: $value)';
}

class SearchSuggestionsLoaded extends SearchState {
  final Weather? weather;
  const SearchSuggestionsLoaded(this.weather);
  @override
  List<Object> get props => [weather!];

  @override
  String toString() => 'SearchSuggestionsLoaded(weather: $weather)';
}

class SearchResultsLoaded extends SearchState {
  final Locations? locations;
  final Weather? weather;
  const SearchResultsLoaded(this.locations, this.weather);
  @override
  List<Object> get props => [locations!, weather!];

  @override
  String toString() =>
      'SearchResultsLoaded(locations: $locations, weather: $weather)';
}

class SearchLoading extends SearchState {}
