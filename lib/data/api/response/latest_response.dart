import 'package:covid19grapherflutter/data/api/response/locations_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'latest_response.g.dart';

@JsonSerializable()
class LatestResponse {
  final LatestData latest;

  const LatestResponse(this.latest);

  factory LatestResponse.fromJson(Map<String, dynamic> json) =>
      _$LatestResponseFromJson(json);

  Map<String, dynamic> toMap() => _$LatestResponseToJson(this);
}
