// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class APIAdapter extends TypeAdapter<API> {
  @override
  final int typeId = 1;

  @override
  API read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return API(
      tubingSize: fields[0] as String,
      outsideDiameter: fields[1] as double,
      insideDiameter: fields[2] as double,
      metalArea: fields[3] as double,
      elasticConstant: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, API obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.tubingSize)
      ..writeByte(1)
      ..write(obj.outsideDiameter)
      ..writeByte(2)
      ..write(obj.insideDiameter)
      ..writeByte(3)
      ..write(obj.metalArea)
      ..writeByte(4)
      ..write(obj.elasticConstant);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is APIAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
