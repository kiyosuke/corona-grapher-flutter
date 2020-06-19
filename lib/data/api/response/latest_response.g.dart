// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'latest_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatestResponse _$LatestResponseFromJson(Map<String, dynamic> json) {
  return LatestResponse(
    json['latest'] == null
        ? null
        : LatestData.fromJson(json['latest'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LatestResponseToJson(LatestResponse instance) =>
    <String, dynamic>{
      'latest': instance.latest,
    };
