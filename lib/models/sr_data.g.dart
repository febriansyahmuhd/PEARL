// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sr_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SRDataAdapter extends TypeAdapter<SRData> {
  @override
  final int typeId = 3;

  @override
  SRData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SRData(
      rodSize: fields[0] as String,
      metalArea: fields[1] as double,
      rodWeight: fields[2] as double,
      elasticConstant: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, SRData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.rodSize)
      ..writeByte(1)
      ..write(obj.metalArea)
      ..writeByte(2)
      ..write(obj.rodWeight)
      ..writeByte(3)
      ..write(obj.elasticConstant);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SRDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
