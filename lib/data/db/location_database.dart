import 'dart:async';
import 'dart:collection';

import 'package:covid19grapherflutter/data/api/response/locations_response.dart';
import 'package:covid19grapherflutter/data/db/entity/location_entity.dart';
import 'package:hive/hive.dart';

class LocationDatabase {
  final Box<LocationEntity> locationBox;

  const LocationDatabase(this.locationBox);

  Future saveLocations(LocationsResponse apiResponse) async {
    final entries = apiResponse.locations
        .map((data) => data.toEntity())
        .associate((entity) => _Pair(entity.id, entity));
    await locationBox.putAll(entries);
  }

  List<LocationEntity> locations() {
    return locationBox.values.toList();
  }
}

extension LocationDataMapper on LocationData {
  LocationEntity toEntity() {
    return LocationEntity(
        id,
        country,
        countryCode,
        countryPopulation,
        province,
        lastUpdated,
        double.tryParse(coordinates.latitude),
        double.tryParse(coordinates.longitude),
        latest.confirmed,
        latest.deaths,
        latest.recovered);
  }
}

extension ListAssociation<T> on Iterable<T> {
  Map<K, V> associate<K, V>(_Pair<K, V> Function(T) transform) {
    final result = LinkedHashMap<K, V>();
    for (var element in this) {
      final newEle = transform(element);
      result.putIfAbsent(newEle.first, () => newEle.second);
    }
    return result;
  }
}

class _Pair<F, S> {
  final F first;
  final S second;

  const _Pair(this.first, this.second);
}
