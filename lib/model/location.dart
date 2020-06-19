import 'package:covid19grapherflutter/model/coordinates.dart';
import 'package:covid19grapherflutter/model/latest.dart';
import 'package:covid19grapherflutter/model/timelines.dart';

class LocationId {
  final int id;

  const LocationId(this.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationId && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'LocationId{id: $id}';
  }
}

class Location {
  final LocationId id;
  final String country;
  final String countryCode;
  final int countryPopulation;
  final String province;
  final DateTime lastUpdated;
  final Coordinates coordinates;
  final Latest latest;
  final Timelines timelines;

  Location(
      this.id,
      this.country,
      this.countryCode,
      this.countryPopulation,
      this.province,
      this.lastUpdated,
      this.coordinates,
      this.latest,
      this.timelines);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Location &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          country == other.country &&
          countryCode == other.countryCode &&
          countryPopulation == other.countryPopulation &&
          province == other.province &&
          lastUpdated == other.lastUpdated &&
          coordinates == other.coordinates &&
          latest == other.latest &&
          timelines == other.timelines;

  @override
  int get hashCode =>
      id.hashCode ^
      country.hashCode ^
      countryCode.hashCode ^
      countryPopulation.hashCode ^
      province.hashCode ^
      lastUpdated.hashCode ^
      coordinates.hashCode ^
      latest.hashCode ^
      timelines.hashCode;

  @override
  String toString() {
    return 'Location{id: $id, country: $country, countryCode: $countryCode, countryPopulation: $countryPopulation, province: $province, lastUpdated: $lastUpdated, coordinates: $coordinates, latest: $latest, timelines: $timelines}';
  }
}

extension CountryFullName on Location {

  String get countryFullName {
    if (province == null || province.isEmpty) {
      return country;
    } else {
      return '$country ($province)';
    }
  }
}
