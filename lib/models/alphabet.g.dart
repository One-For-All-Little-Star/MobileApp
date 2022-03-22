// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alphabet.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlphabetAdapter extends TypeAdapter<Alphabet> {
  @override
  final int typeId = 1;

  @override
  Alphabet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Alphabet(
      letter: fields[0] as String,
      image: fields[1] as String,
      isLock: fields[2] as bool,
      numOfstars: fields[3] as int,
      routeName: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Alphabet obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.letter)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.isLock)
      ..writeByte(3)
      ..write(obj.numOfstars)
      ..writeByte(4)
      ..write(obj.routeName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlphabetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
