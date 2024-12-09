// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'f3skr.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class F3SkrModelAdapter extends TypeAdapter<F3SkrModel> {
  @override
  final int typeId = 10;

  @override
  F3SkrModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return F3SkrModel(
      nNo: fields[0] as String,
      f3Skr0_1: fields[1] as double,
      f3Skr0_2: fields[2] as double,
      f3Skr0_3: fields[3] as double,
      f3Skr0_4: fields[4] as double,
      f3Skr0_5: fields[5] as double,
      f3Skr0_6: fields[6] as double,
    );
  }

  @override
  void write(BinaryWriter writer, F3SkrModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.nNo)
      ..writeByte(1)
      ..write(obj.f3Skr0_1)
      ..writeByte(2)
      ..write(obj.f3Skr0_2)
      ..writeByte(3)
      ..write(obj.f3Skr0_3)
      ..writeByte(4)
      ..write(obj.f3Skr0_4)
      ..writeByte(5)
      ..write(obj.f3Skr0_5)
      ..writeByte(6)
      ..write(obj.f3Skr0_6);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is F3SkrModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
