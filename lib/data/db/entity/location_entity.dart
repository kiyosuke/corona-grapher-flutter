import 'package:hive/hive.dart';

part 'location_entity.g.dart';

@HiveType(typeId: 1)
class LocationEntity {
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String country;
  @HiveField(3)
  final String countryCode;
  @HiveField(4)
  final int countryPopulation;
  @HiveField(5)
  final String province;
  @HiveField(6)
  final DateTime lastUpdated;
  @HiveField(7)
  final double latitude;
  @HiveField(8)
  final double longitude;
  @HiveField(9)
  final int lastConfirmed;
  @HiveField(10)
  final int lastDeaths;
  @HiveField(11)
  final int lastRecovered;

  const LocationEntity(
      this.id,
      this.country,
      this.countryCode,
      this.countryPopulation,
      this.province,
      this.lastUpdated,
      this.latitude,
      this.longitude,
      this.lastConfirmed,
      this.lastDeaths,
      this.lastRecovered);
}
