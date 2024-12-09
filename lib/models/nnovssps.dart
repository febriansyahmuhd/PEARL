import 'package:hive/hive.dart';

part 'nnovssps.g.dart';

@HiveType(typeId: 7) // Assign a unique typeId for Hive
class nnovssps {
  @HiveField(0)
  final String nNo;

  @HiveField(1)
  final double spS0_05;

  @HiveField(2)
  final double spS0_1;

  @HiveField(3)
  final double spS0_2;

  @HiveField(4)
  final double spS0_3;

  @HiveField(5)
  final double spS0_4;

  @HiveField(6)
  final double spS0_5;

  nnovssps({
    required this.nNo,
    required this.spS0_05,
    required this.spS0_1,
    required this.spS0_2,
    required this.spS0_3,
    required this.spS0_4,
    required this.spS0_5,
  });

  // Factory method to create a nnovssps instance from JSON
  factory nnovssps.fromJson(Map<String, dynamic> json) {
    return nnovssps(
      nNo: json['N/No'],
      spS0_05: double.parse(json['Sp/S0.05']),
      spS0_1: double.parse(json['Sp/S0.1']),
      spS0_2: double.parse(json['Sp/S0.2']),
      spS0_3: double.parse(json['Sp/S0.3']),
      spS0_4: double.parse(json['Sp/S0.4']),
      spS0_5: double.parse(json['Sp/S0.5']),
    );
  }

  // Method to convert nnovssps to JSON
  Map<String, dynamic> toJson() {
    return {
      'N/No': nNo,
      'Sp/S0.05': spS0_05.toString(),
      'Sp/S0.1': spS0_1.toString(),
      'Sp/S0.2': spS0_2.toString(),
      'Sp/S0.3': spS0_3.toString(),
      'Sp/S0.4': spS0_4.toString(),
      'Sp/S0.5': spS0_5.toString(),
    };
  }

  // Method to create a list of nnovssps instances from a JSON list
  static List<nnovssps> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => nnovssps.fromJson(json)).toList();
  }
}
