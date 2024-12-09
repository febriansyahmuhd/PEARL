import 'package:hive/hive.dart';

part 'api.g.dart';

@HiveType(typeId: 1) // Ensure this typeId is unique
class API {
  @HiveField(0)
  String tubingSize;

  @HiveField(1)
  double outsideDiameter;

  @HiveField(2)
  double insideDiameter;

  @HiveField(3)
  double metalArea;

  @HiveField(4)
  double elasticConstant;

  API({
    required this.tubingSize,
    required this.outsideDiameter,
    required this.insideDiameter,
    required this.metalArea,
    required this.elasticConstant,
  });
}
