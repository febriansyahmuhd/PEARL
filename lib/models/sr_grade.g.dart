// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sr_grade.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SRGradeAdapter extends TypeAdapter<SRGrade> {
  @override
  final int typeId = 4;

  @override
  SRGrade read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SRGrade(
      apiGrade: fields[0] as String?,
      yieldStrength: fields[1] as String?,
      tensileStrength: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SRGrade obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.apiGrade)
      ..writeByte(1)
      ..write(obj.yieldStrength)
      ..writeByte(2)
      ..write(obj.tensileStrength);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SRGradeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
