import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/logic/bloc/search_bloc.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    required this.mounted,
  }) : super(key: key);

  final bool mounted;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 15, right: 15),
        child: TextField(
          onChanged: (String value) async {
            await Future.delayed(const Duration(milliseconds: 100));
            if (!mounted) {
              return;
            } //need to make sure that widget is mounted if we want to use context after async

            if (value.isNotEmpty) {
              context.read<SearchBloc>().add(SearchValueUpdated(value.trim()));
            } else {
              context.read<SearchBloc>().add(const SearchValueUpdated(null));
            }
          },
        ));
  }
}
