// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocationEntityAdapter extends TypeAdapter<LocationEntity> {
  @override
  final typeId = 1;

  @override
  LocationEntity read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocationEntity(
      fields[1] as int,
      fields[2] as String,
      fields[3] as String,
      fields[4] as int,
      fields[5] as String,
      fields[6] as DateTime,
      fields[7] as double,
      fields[8] as double,
      fields[9] as int,
      fields[10] as int,
      fields[11] as int,
    );
  }

  @override
  void write(BinaryWriter writer, LocationEntity obj) {
    writer
      ..writeByte(11)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.country)
      ..writeByte(3)
      ..write(obj.countryCode)
      ..writeByte(4)
      ..write(obj.countryPopulation)
      ..writeByte(5)
      ..write(obj.province)
      ..writeByte(6)
      ..write(obj.lastUpdated)
      ..writeByte(7)
      ..write(obj.latitude)
      ..writeByte(8)
      ..write(obj.longitude)
      ..writeByte(9)
      ..write(obj.lastConfirmed)
      ..writeByte(10)
      ..write(obj.lastDeaths)
      ..writeByte(11)
      ..write(obj.lastRecovered);
  }
}
