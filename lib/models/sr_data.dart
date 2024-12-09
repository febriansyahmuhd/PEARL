import 'package:hive/hive.dart';

part 'sr_data.g.dart'; // This is required for Hive to generate the adapter code

@HiveType(typeId: 3) // Ensure to use a unique typeId for each model
class SRData {
  @HiveField(0)
  String rodSize;

  @HiveField(1)
  double metalArea;

  @HiveField(2)
  double rodWeight;

  @HiveField(3)
  double elasticConstant;

  SRData({
    required this.rodSize,
    required this.metalArea,
    required this.rodWeight,
    required this.elasticConstant,
  });
}
