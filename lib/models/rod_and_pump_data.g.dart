// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rod_and_pump_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RodPumpDataAdapter extends TypeAdapter<RodPumpData> {
  @override
  final int typeId = 6;

  @override
  RodPumpData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RodPumpData(
      rodNo: fields[0] as String,
      plungerDiameter: fields[1] as String,
      rodWeight: fields[2] as double,
      elasticConstant: fields[3] as double,
      frequencyFactor: fields[4] as double,
      rodString11_8: fields[5] as double,
      rodString1: fields[6] as double,
      rodString7_8: fields[7] as double,
      rodString3_4: fields[8] as double,
      rodString5_8: fields[9] as double,
      rodString1_2: fields[10] as double,
    );
  }

  @override
  void write(BinaryWriter writer, RodPumpData obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.rodNo)
      ..writeByte(1)
      ..write(obj.plungerDiameter)
      ..writeByte(2)
      ..write(obj.rodWeight)
      ..writeByte(3)
      ..write(obj.elasticConstant)
      ..writeByte(4)
      ..write(obj.frequencyFactor)
      ..writeByte(5)
      ..write(obj.rodString11_8)
      ..writeByte(6)
      ..write(obj.rodString1)
      ..writeByte(7)
      ..write(obj.rodString7_8)
      ..writeByte(8)
      ..write(obj.rodString3_4)
      ..writeByte(9)
      ..write(obj.rodString5_8)
      ..writeByte(10)
      ..write(obj.rodString1_2);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RodPumpDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
