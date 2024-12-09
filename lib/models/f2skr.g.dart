// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'f2skr.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class F2SkrModelAdapter extends TypeAdapter<F2SkrModel> {
  @override
  final int typeId = 9;

  @override
  F2SkrModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return F2SkrModel(
      nNo: fields[0] as String,
      f2Skr0_1: fields[1] as double,
      f2Skr0_2: fields[2] as double,
      f2Skr0_3: fields[3] as double,
      f2Skr0_4: fields[4] as double,
      f2Skr0_5: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, F2SkrModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.nNo)
      ..writeByte(1)
      ..write(obj.f2Skr0_1)
      ..writeByte(2)
      ..write(obj.f2Skr0_2)
      ..writeByte(3)
      ..write(obj.f2Skr0_3)
      ..writeByte(4)
      ..write(obj.f2Skr0_4)
      ..writeByte(5)
      ..write(obj.f2Skr0_5);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is F2SkrModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
