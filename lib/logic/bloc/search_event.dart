part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchValueUpdated extends SearchEvent {
  final String? value;
  const SearchValueUpdated(this.value);

  int? get valueLength => value!.length;
}
