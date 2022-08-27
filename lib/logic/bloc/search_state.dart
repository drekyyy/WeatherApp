part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchShow extends SearchState {
  final Cities? cities;
  const SearchShow(this.cities);
  @override
  List<Object> get props => [cities!];
}
