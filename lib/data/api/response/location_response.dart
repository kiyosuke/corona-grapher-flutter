import 'package:covid19grapherflutter/data/api/response/locations_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location_response.g.dart';

@JsonSerializable()
class LocationResponse {

  final LocationData location;

  const LocationResponse(this.location);

  factory LocationResponse.fromJson(Map<String, dynamic> json) =>
      _$LocationResponseFromJson(json);

  Map<String, dynamic> toMap() => _$LocationResponseToJson(this);
}