// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'f0skr.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class F0SkrModelAdapter extends TypeAdapter<F0SkrModel> {
  @override
  final int typeId = 12;

  @override
  F0SkrModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return F0SkrModel(
      nNo: fields[0] as String,
      f0Skr15: fields[1] as double,
      f0Skr10: fields[2] as double,
      f0Skr7_5: fields[3] as double,
      f0Skr5: fields[4] as double,
      f0Skr3: fields[5] as double,
      f0Skr1_5: fields[6] as double,
      f0Skr1: fields[7] as double,
      f0Skr0: fields[8] as double,
      f0Skr_1_75: fields[9] as double,
      f0Skr_1_75_2: fields[10] as double,
      f0Skr0_2: fields[11] as double,
      f0Skr1_2: fields[12] as double,
      f0Skr1_5_2: fields[13] as double,
    );
  }

  @override
  void write(BinaryWriter writer, F0SkrModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.nNo)
      ..writeByte(1)
      ..write(obj.f0Skr15)
      ..writeByte(2)
      ..write(obj.f0Skr10)
      ..writeByte(3)
      ..write(obj.f0Skr7_5)
      ..writeByte(4)
      ..write(obj.f0Skr5)
      ..writeByte(5)
      ..write(obj.f0Skr3)
      ..writeByte(6)
      ..write(obj.f0Skr1_5)
      ..writeByte(7)
      ..write(obj.f0Skr1)
      ..writeByte(8)
      ..write(obj.f0Skr0)
      ..writeByte(9)
      ..write(obj.f0Skr_1_75)
      ..writeByte(10)
      ..write(obj.f0Skr_1_75_2)
      ..writeByte(11)
      ..write(obj.f0Skr0_2)
      ..writeByte(12)
      ..write(obj.f0Skr1_2)
      ..writeByte(13)
      ..write(obj.f0Skr1_5_2);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is F0SkrModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
