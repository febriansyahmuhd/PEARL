// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'twotskr.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TwoTSkrModelAdapter extends TypeAdapter<TwoTSkrModel> {
  @override
  final int typeId = 11;

  @override
  TwoTSkrModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TwoTSkrModel(
      nNo: fields[0] as String,
      tSkr0_1: fields[1] as double,
      tSkr0_2: fields[2] as double,
      tSkr0_3: fields[3] as double,
      tSkr0_4: fields[4] as double,
      tSkr0_5: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, TwoTSkrModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.nNo)
      ..writeByte(1)
      ..write(obj.tSkr0_1)
      ..writeByte(2)
      ..write(obj.tSkr0_2)
      ..writeByte(3)
      ..write(obj.tSkr0_3)
      ..writeByte(4)
      ..write(obj.tSkr0_4)
      ..writeByte(5)
      ..write(obj.tSkr0_5);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TwoTSkrModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
