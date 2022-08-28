part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchSuggestions extends SearchState {
  final Locations? locations;
  const SearchSuggestions(this.locations);
  @override
  List<Object> get props => [locations!];
}

class SearchValidation extends SearchState {
  final String message;
  const SearchValidation(this.message);

  @override
  List<Object> get props => [message];
}

class SearchValueStorage extends SearchState {
  final String? searchValue;
  const SearchValueStorage(this.searchValue);

  String? get valuee {
    return searchValue;
  }

  @override
  List<Object> get props => [searchValue!];
}
