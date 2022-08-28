part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchSuggestionsDisplayed extends SearchEvent {
  String? loc;
  SearchSuggestionsDisplayed(this.loc);
  int? get locLength => loc!.length;
}

class SearchValueUpdated extends SearchEvent {
  String? loc;
  SearchValueUpdated(this.loc);
}
