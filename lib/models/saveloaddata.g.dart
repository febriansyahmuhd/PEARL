// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saveloaddata.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class saveloaddataAdapter extends TypeAdapter<saveloaddata> {
  @override
  final int typeId = 12;

  @override
  saveloaddata read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return saveloaddata(
      name: fields[0] as String,
      wellName: fields[1] as String,
      date: fields[2] as String,
      selectedRodNo: fields[3] as String,
      selectedTubingSize: fields[4] as String,
      selectedPlungerDiameter: fields[5] as String,
      selectedApiGrade: fields[6] as String,
      selectedTensileStrength: fields[7] as String,
      selectedPUType: fields[8] as String,
      selectedPUTypeval: fields[9] as String,
      selectedElasticConstant: fields[10] as String,
      pd: fields[11] as String,
      smg: fields[12] as String,
      fsg: fields[13] as String,
      pe: fields[14] as String,
      sf: fields[15] as String,
      sl: fields[16] as String,
      ps: fields[17] as String,
    );
  }

  @override
  void write(BinaryWriter writer, saveloaddata obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.wellName)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.selectedRodNo)
      ..writeByte(4)
      ..write(obj.selectedTubingSize)
      ..writeByte(5)
      ..write(obj.selectedPlungerDiameter)
      ..writeByte(6)
      ..write(obj.selectedApiGrade)
      ..writeByte(7)
      ..write(obj.selectedTensileStrength)
      ..writeByte(8)
      ..write(obj.selectedPUType)
      ..writeByte(9)
      ..write(obj.selectedPUTypeval)
      ..writeByte(10)
      ..write(obj.selectedElasticConstant)
      ..writeByte(11)
      ..write(obj.pd)
      ..writeByte(12)
      ..write(obj.smg)
      ..writeByte(13)
      ..write(obj.fsg)
      ..writeByte(14)
      ..write(obj.pe)
      ..writeByte(15)
      ..write(obj.sf)
      ..writeByte(16)
      ..write(obj.sl)
      ..writeByte(17)
      ..write(obj.ps);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is saveloaddataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
