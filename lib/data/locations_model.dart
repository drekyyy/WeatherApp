// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Locations {
  List<Map<String, dynamic>>? locations;
  Locations({
    this.locations,
  });

  Locations copyWith({
    List<Map<String, dynamic>>? locations,
  }) {
    return Locations(
      locations: locations ?? this.locations,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'locations': locations,
    };
  }

  String toJson() => json.encode(toMap());

  factory Locations.fromJson(var json) {
    //this var is always List<dynamic>?
    List<Map<String, dynamic>>? getValueFromNestedJson(var jsonDynamicList) {
      //each json[i] is a Map<String, dynamic>, so we add them all to the list

      // we create this list just to get length of json (how many nexted json there are)
      List<String> list = jsonDynamicList.toString().split('}, {');

      List<Map<String, dynamic>>? listOfMaps = [];
      Set<String> setofLocations = {};
      for (int i = 0; i < list.length; i++) {
        int setLengthBefore = setofLocations.length;
        //set doesnt store the same values, i dont want duplicates that have the same name and state
        //(it sometimes shows the same location but with slightly different coordinates) hance this method is used
        setofLocations
            .add('${jsonDynamicList[i]['name']}${jsonDynamicList[i]['state']}');
        int setLengthAfter = setofLocations.length;
        if (setLengthAfter == setLengthBefore + 1) {
          listOfMaps.add(jsonDynamicList[i]);
        }
      }
      return listOfMaps;
    }

    return Locations(locations: getValueFromNestedJson(json));
  }

  @override
  String toString() => 'Locations(locations: $locations)';

  @override
  bool operator ==(covariant Locations other) {
    if (identical(this, other)) return true;

    return listEquals(other.locations, locations);
  }

  operator [](int index) {
    return locations![
        index]; //should i use this[index] instead of cities[index]?
    // dart says no? but looks nicer for sure
  }

  int get length {
    if (locations != null) {
      return locations!.length;
    } else {
      return 0;
    }
  }

  @override
  int get hashCode => locations.hashCode;
}
