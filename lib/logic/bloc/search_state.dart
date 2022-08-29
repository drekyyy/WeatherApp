// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchHasValue extends SearchState {
  final String? value;
  const SearchHasValue(this.value);
  @override
  List<Object> get props => [value!];

  @override
  String toString() => 'SearchWithValue(value: $value)';
}

class SearchSuggestionsLoaded extends SearchState {
  final Locations? locations;
  const SearchSuggestionsLoaded(this.locations);
  @override
  List<Object> get props => [locations!];

  @override
  String toString() => 'SearchSuggestionsLoaded(locations: $locations)';
}
