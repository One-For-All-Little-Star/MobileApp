// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_use.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimeUseAdapter extends TypeAdapter<TimeUse> {
  @override
  final int typeId = 3;

  @override
  TimeUse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimeUse(
      day: fields[0] as String,
      watchVideo: fields[1] as num,
      learn: fields[2] as num,
    );
  }

  @override
  void write(BinaryWriter writer, TimeUse obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.day)
      ..writeByte(1)
      ..write(obj.watchVideo)
      ..writeByte(2)
      ..write(obj.learn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeUseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
