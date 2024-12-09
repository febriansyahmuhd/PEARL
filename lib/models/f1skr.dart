import 'package:hive/hive.dart';

part 'f1skr.g.dart';

@HiveType(typeId: 8) // Assign a unique typeId for Hive
class F1SkrModel {
  @HiveField(0)
  final String nNo;

  @HiveField(1)
  final double f1Skr0_1;

  @HiveField(2)
  final double f1Skr0_2;

  @HiveField(3)
  final double f1Skr0_3;

  @HiveField(4)
  final double f1Skr0_4;

  @HiveField(5)
  final double f1Skr0_5;

  F1SkrModel({
    required this.nNo,
    required this.f1Skr0_1,
    required this.f1Skr0_2,
    required this.f1Skr0_3,
    required this.f1Skr0_4,
    required this.f1Skr0_5,
  });

  factory F1SkrModel.fromJson(Map<String, dynamic> json) {
    return F1SkrModel(
      nNo: json['N/No'],
      f1Skr0_1: double.parse(json['F1/Skr0.1']),
      f1Skr0_2: double.parse(json['F1/Skr0.2']),
      f1Skr0_3: double.parse(json['F1/Skr0.3']),
      f1Skr0_4: double.parse(json['F1/Skr0.4']),
      f1Skr0_5: double.parse(json['F1/Skr0.5']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'N/No': nNo,
      'F1/Skr0.1': f1Skr0_1.toString(),
      'F1/Skr0.2': f1Skr0_2.toString(),
      'F1/Skr0.3': f1Skr0_3.toString(),
      'F1/Skr0.4': f1Skr0_4.toString(),
      'F1/Skr0.5': f1Skr0_5.toString(),
    };
  }

  static List<F1SkrModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => F1SkrModel.fromJson(json)).toList();
  }
}
