// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pu_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PUTypeAdapter extends TypeAdapter<PUType> {
  @override
  final int typeId = 0;

  @override
  PUType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PUType(
      conventional: fields[0] as String?,
      markII: fields[1] as String?,
      airBalance: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PUType obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.conventional)
      ..writeByte(1)
      ..write(obj.markII)
      ..writeByte(2)
      ..write(obj.airBalance);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PUTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
