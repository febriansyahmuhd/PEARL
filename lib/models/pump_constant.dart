import 'package:hive/hive.dart';

part 'pump_constant.g.dart';

@HiveType(typeId: 2)  // Ensure to change typeId if needed
class PumpConstant {
  @HiveField(0)
  String? plungerDiameter;

  @HiveField(1)
  String? plungerArea;

  @HiveField(2)
  String? fluidLoadFactor;

  @HiveField(3)
  String? pumpFactor;

  PumpConstant({
    this.plungerDiameter,
    this.plungerArea,
    this.fluidLoadFactor,
    this.pumpFactor,
  });
}
