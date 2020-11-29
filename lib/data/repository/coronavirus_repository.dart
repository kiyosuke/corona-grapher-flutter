import 'package:covid19grapherflutter/data/api/coronavius_api.dart';
import 'package:covid19grapherflutter/data/api/response/locations_response.dart';
import 'package:covid19grapherflutter/data/db/entity/location_entity.dart';
import 'package:covid19grapherflutter/data/db/location_database.dart';
import 'package:covid19grapherflutter/model/coordinates.dart';
import 'package:covid19grapherflutter/model/latest.dart';
import 'package:covid19grapherflutter/model/location.dart';
import 'package:covid19grapherflutter/model/timeline.dart';
import 'package:covid19grapherflutter/model/timelines.dart';
import 'package:flutter_riverpod/all.dart';

final repoProvider = Provider<CoronavirusRepository>((ref) {
  final db = ref.read(dbProvider);
  final api = ref.read(apiProvider);
  return CoronavirusRepository(api, db);
});

class CoronavirusRepository {
  final CoronaviusApi _api;
  final LocationDatabase _db;

  CoronavirusRepository(this._api, this._db);

  Future refreshLocations() async {
    final apiResponse = await _api.allLocations();
    await _db.saveLocations(apiResponse);
  }

  List<Location> locations() {
    return _db.locations().toModels();
  }

  Future<Location> location(LocationId id) async {
    final apiResponse = await _api.location(id.id);
    return apiResponse.location.toModel();
  }

  Future<Latest> latest() async {
    final apiResponse = await _api.latest();
    return apiResponse.latest.toModel();
  }
}

extension LocationEntitiesMapper on List<LocationEntity> {
  List<Location> toModels() {
    return map((e) => Location(
        LocationId(e.id),
        e.country,
        e.countryCode,
        e.countryPopulation,
        e.province,
        e.lastUpdated,
        Coordinates(e.latitude, e.longitude),
        Latest(e.lastConfirmed, e.lastDeaths, e.lastRecovered),
        null)).toList();
  }
}

extension LocationDataMapper on LocationData {
  Location toModel() {
    return Location(
        LocationId(id),
        country,
        countryCode,
        countryPopulation,
        province,
        lastUpdated,
        coordinates.toModel(),
        latest.toModel(),
        Timelines(timelines.confirmed.toModel(), timelines.deaths.toModel(),
            timelines.recovered.toModel()));
  }
}

extension CoordinatesMapper on CoordinatesResponse {
  Coordinates toModel() {
    return Coordinates(double.tryParse(latitude), double.tryParse(longitude));
  }
}

extension TimelineMapper on TimelineResponse {
  Timeline toModel() {
    return Timeline(latest,
        timeline.map((key, value) => MapEntry(_parseDateString(key), value)));
  }

  DateTime _parseDateString(String date) {
    return DateTime.parse(date);
  }
}

extension LatestDataMaper on LatestData {
  Latest toModel() {
    return Latest(confirmed, deaths, recovered);
  }
}
