import 'package:hive/hive.dart';

part 'rod_and_pump_data.g.dart';

@HiveType(typeId: 6) // Make sure to assign a unique typeId for Hive
class RodPumpData {
  @HiveField(0)
  final String rodNo;

  @HiveField(1)
  final String plungerDiameter;

  @HiveField(2)
  final double rodWeight;

  @HiveField(3)
  final double elasticConstant;

  @HiveField(4)
  final double frequencyFactor;

  @HiveField(5)
  final double rodString11_8;

  @HiveField(6)
  final double rodString1;

  @HiveField(7)
  final double rodString7_8;

  @HiveField(8)
  final double rodString3_4;

  @HiveField(9)
  final double rodString5_8;

  @HiveField(10)
  final double rodString1_2;

  RodPumpData({
    required this.rodNo,
    required this.plungerDiameter,
    required this.rodWeight,
    required this.elasticConstant,
    required this.frequencyFactor,
    required this.rodString11_8,
    required this.rodString1,
    required this.rodString7_8,
    required this.rodString3_4,
    required this.rodString5_8,
    required this.rodString1_2,
  });

  // Factory method to create a RodPumpData instance from JSON
  factory RodPumpData.fromJson(Map<String, dynamic> json) {
    return RodPumpData(
      rodNo: json['rodNo'],
      plungerDiameter: json['plungerDiameter'],
      rodWeight: double.parse(json['rodWeight']),
      elasticConstant: double.parse(json['elasticConstant']),
      frequencyFactor: double.parse(json['frequencyFactor']),
      rodString11_8: double.parse(json['rodString11/8']),
      rodString1: double.parse(json['rodString1']),
      rodString7_8: double.parse(json['rodString7/8']),
      rodString3_4: double.parse(json['rodString3/4']),
      rodString5_8: double.parse(json['rodString5/8']),
      rodString1_2: double.parse(json['rodString1/2']),
    );
  }

  // Method to convert RodPumpData to JSON
  Map<String, dynamic> toJson() {
    return {
      'rodNo': rodNo,
      'plungerDiameter': plungerDiameter,
      'rodWeight': rodWeight.toString(),
      'elasticConstant': elasticConstant.toString(),
      'frequencyFactor': frequencyFactor.toString(),
      'rodString11/8': rodString11_8.toString(),
      'rodString1': rodString1.toString(),
      'rodString7/8': rodString7_8.toString(),
      'rodString3/4': rodString3_4.toString(),
      'rodString5/8': rodString5_8.toString(),
      'rodString1/2': rodString1_2.toString(),
    };
  }

  // Method to create a list of RodPumpData instances from a JSON list
  static List<RodPumpData> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => RodPumpData.fromJson(json)).toList();
  }
}
