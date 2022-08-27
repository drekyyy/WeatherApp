// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Cities {
  List<Map<String, dynamic>>? cities;
  Cities({
    this.cities,
  });

  Cities copyWith({
    List<Map<String, dynamic>>? cities,
  }) {
    return Cities(
      cities: cities ?? this.cities,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cities': cities,
    };
  }

  String toJson() => json.encode(toMap());

  factory Cities.fromJson(var json) {
    //this var is always List<dynamic>?
    List<Map<String, dynamic>>? getValueFromNestedJson(var jsonDynamicList) {
      //each json[i] is a Map<String, dynamic>, so we add them all to the list
      List<String> list = jsonDynamicList.toString().split('}, {');

      List<Map<String, dynamic>>? listOfMaps = [];
      for (int i = 0; i < list.length; i++) {
        print('${jsonDynamicList[i]}');
        listOfMaps.add(jsonDynamicList[i]);
      }

      return listOfMaps;
    }

    return Cities(cities: getValueFromNestedJson(json));
  }

  @override
  String toString() => 'Cities(cities: $cities)';

  @override
  bool operator ==(covariant Cities other) {
    if (identical(this, other)) return true;

    return listEquals(other.cities, cities);
  }

  operator [](int index) {
    return cities![index]; //should i use this[index] instead of cities[index]?
    // dart says no? but looks nicer for sure
  }

  int get length {
    if (cities != null) {
      return cities!.length;
    } else {
      return 0;
    }
  }

  @override
  int get hashCode => cities.hashCode;
}
