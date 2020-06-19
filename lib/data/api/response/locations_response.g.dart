// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationsResponse _$LocationsResponseFromJson(Map<String, dynamic> json) {
  return LocationsResponse(
    json['latest'] == null
        ? null
        : LatestData.fromJson(json['latest'] as Map<String, dynamic>),
    (json['locations'] as List)
        ?.map((e) =>
            e == null ? null : LocationData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$LocationsResponseToJson(LocationsResponse instance) =>
    <String, dynamic>{
      'latest': instance.latest,
      'locations': instance.locations,
    };

LatestData _$LatestDataFromJson(Map<String, dynamic> json) {
  return LatestData(
    json['confirmed'] as int,
    json['deaths'] as int,
    json['recovered'] as int,
  );
}

Map<String, dynamic> _$LatestDataToJson(LatestData instance) =>
    <String, dynamic>{
      'confirmed': instance.confirmed,
      'deaths': instance.deaths,
      'recovered': instance.recovered,
    };

LocationData _$LocationDataFromJson(Map<String, dynamic> json) {
  return LocationData(
    json['id'] as int,
    json['country'] as String,
    json['country_code'] as String,
    json['country_population'] as int,
    json['province'] as String,
    json['last_updated'] == null
        ? null
        : DateTime.parse(json['last_updated'] as String),
    json['coordinates'] == null
        ? null
        : CoordinatesResponse.fromJson(
            json['coordinates'] as Map<String, dynamic>),
    json['latest'] == null
        ? null
        : LatestData.fromJson(json['latest'] as Map<String, dynamic>),
    json['timelines'] == null
        ? null
        : TimelinesResponse.fromJson(json['timelines'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LocationDataToJson(LocationData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'country': instance.country,
      'country_code': instance.countryCode,
      'country_population': instance.countryPopulation,
      'province': instance.province,
      'last_updated': instance.lastUpdated?.toIso8601String(),
      'coordinates': instance.coordinates,
      'latest': instance.latest,
      'timelines': instance.timelines,
    };

CoordinatesResponse _$CoordinatesResponseFromJson(Map<String, dynamic> json) {
  return CoordinatesResponse(
    json['latitude'] as String,
    json['longitude'] as String,
  );
}

Map<String, dynamic> _$CoordinatesResponseToJson(
        CoordinatesResponse instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

TimelinesResponse _$TimelinesResponseFromJson(Map<String, dynamic> json) {
  return TimelinesResponse(
    json['confirmed'] == null
        ? null
        : TimelineResponse.fromJson(json['confirmed'] as Map<String, dynamic>),
    json['deaths'] == null
        ? null
        : TimelineResponse.fromJson(json['deaths'] as Map<String, dynamic>),
    json['recovered'] == null
        ? null
        : TimelineResponse.fromJson(json['recovered'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TimelinesResponseToJson(TimelinesResponse instance) =>
    <String, dynamic>{
      'confirmed': instance.confirmed,
      'deaths': instance.deaths,
      'recovered': instance.recovered,
    };

TimelineResponse _$TimelineResponseFromJson(Map<String, dynamic> json) {
  return TimelineResponse(
    json['latest'] as int,
    (json['timeline'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as int),
    ),
  );
}

Map<String, dynamic> _$TimelineResponseToJson(TimelineResponse instance) =>
    <String, dynamic>{
      'latest': instance.latest,
      'timeline': instance.timeline,
    };
