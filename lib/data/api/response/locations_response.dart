import 'package:json_annotation/json_annotation.dart';

part 'locations_response.g.dart';

@JsonSerializable()
class LocationsResponse {
  final LatestData latest;
  final List<LocationData> locations;

  const LocationsResponse(this.latest, this.locations);

  factory LocationsResponse.fromJson(Map<String, dynamic> json) =>
      _$LocationsResponseFromJson(json);

  Map<String, dynamic> toMap() => _$LocationsResponseToJson(this);
}

@JsonSerializable()
class LatestData {
  final int confirmed;
  final int deaths;
  final int recovered;

  const LatestData(this.confirmed, this.deaths, this.recovered);

  factory LatestData.fromJson(Map<String, dynamic> json) => _$LatestDataFromJson(json);

  Map<String, dynamic> toMap() => _$LatestDataToJson(this);
}

@JsonSerializable()
class LocationData {
  final int id;
  final String country;
  @JsonKey(name: 'country_code')
  final String countryCode;
  @JsonKey(name: 'country_population')
  final int countryPopulation;
  final String province;
  @JsonKey(name: 'last_updated')
  final DateTime lastUpdated;
  final CoordinatesResponse coordinates;
  final LatestData latest;
  final TimelinesResponse timelines;

  const LocationData(this.id, this.country, this.countryCode, this.countryPopulation, this.province, this.lastUpdated, this.coordinates, this.latest, this.timelines);

  factory LocationData.fromJson(Map<String, dynamic> json) => _$LocationDataFromJson(json);

  Map<String, dynamic> toMap() => _$LocationDataToJson(this);
}

@JsonSerializable()
class CoordinatesResponse {
  final String latitude;
  final String longitude;

  const CoordinatesResponse(this.latitude, this.longitude);

  factory CoordinatesResponse.fromJson(Map<String, dynamic> json) => _$CoordinatesResponseFromJson(json);

  Map<String, dynamic> toMap() => _$CoordinatesResponseToJson(this);

}

@JsonSerializable()
class TimelinesResponse {
  final TimelineResponse confirmed;
  final TimelineResponse deaths;
  final TimelineResponse recovered;

  const TimelinesResponse(this.confirmed, this.deaths, this.recovered);

  factory TimelinesResponse.fromJson(Map<String, dynamic> json) => _$TimelinesResponseFromJson(json);

  Map<String, dynamic> toMap() => _$TimelinesResponseToJson(this);
}

@JsonSerializable()
class TimelineResponse {
  final int latest;
  final Map<String, int> timeline;

  const TimelineResponse(this.latest, this.timeline);

  factory TimelineResponse.fromJson(Map<String, dynamic> json) => _$TimelineResponseFromJson(json);

  Map<String, dynamic> toMap() => _$TimelineResponseToJson(this);
}