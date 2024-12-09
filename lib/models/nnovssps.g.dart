// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nnovssps.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class nnovsspsAdapter extends TypeAdapter<nnovssps> {
  @override
  final int typeId = 7;

  @override
  nnovssps read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return nnovssps(
      nNo: fields[0] as String,
      spS0_05: fields[1] as double,
      spS0_1: fields[2] as double,
      spS0_2: fields[3] as double,
      spS0_3: fields[4] as double,
      spS0_4: fields[5] as double,
      spS0_5: fields[6] as double,
    );
  }

  @override
  void write(BinaryWriter writer, nnovssps obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.nNo)
      ..writeByte(1)
      ..write(obj.spS0_05)
      ..writeByte(2)
      ..write(obj.spS0_1)
      ..writeByte(3)
      ..write(obj.spS0_2)
      ..writeByte(4)
      ..write(obj.spS0_3)
      ..writeByte(5)
      ..write(obj.spS0_4)
      ..writeByte(6)
      ..write(obj.spS0_5);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is nnovsspsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
