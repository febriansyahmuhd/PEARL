// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sr_api.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SRAPIAdapter extends TypeAdapter<SR_API> {
  @override
  final int typeId = 5;

  @override
  SR_API read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SR_API(
      rodNo: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SR_API obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.rodNo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SRAPIAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
