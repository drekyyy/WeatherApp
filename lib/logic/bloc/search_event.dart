// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  @override
  String toString() => 'SearchValueUpdated(value: $value)';
}
