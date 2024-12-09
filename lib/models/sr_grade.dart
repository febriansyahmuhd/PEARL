import 'package:hive/hive.dart';

part 'sr_grade.g.dart';

@HiveType(typeId: 4) // Each HiveType needs a unique `typeId`
class SRGrade {
  @HiveField(0)
  String? apiGrade;

  @HiveField(1)
  String? yieldStrength;

  @HiveField(2)
  String? tensileStrength;

  SRGrade({
    this.apiGrade,
    this.yieldStrength,
    this.tensileStrength,
  });
}
