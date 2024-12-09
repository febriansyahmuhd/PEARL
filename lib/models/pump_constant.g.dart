// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pump_constant.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PumpConstantAdapter extends TypeAdapter<PumpConstant> {
  @override
  final int typeId = 2;

  @override
  PumpConstant read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PumpConstant(
      plungerDiameter: fields[0] as String?,
      plungerArea: fields[1] as String?,
      fluidLoadFactor: fields[2] as String?,
      pumpFactor: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PumpConstant obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.plungerDiameter)
      ..writeByte(1)
      ..write(obj.plungerArea)
      ..writeByte(2)
      ..write(obj.fluidLoadFactor)
      ..writeByte(3)
      ..write(obj.pumpFactor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PumpConstantAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
