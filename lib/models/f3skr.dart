import 'package:hive/hive.dart';

part 'f3skr.g.dart';

@HiveType(typeId: 10) // Assign a unique typeId for Hive
class F3SkrModel {
  @HiveField(0)
  final String nNo;

  @HiveField(1)
  final double f3Skr0_1;

  @HiveField(2)
  final double f3Skr0_2;

  @HiveField(3)
  final double f3Skr0_3;

  @HiveField(4)
  final double f3Skr0_4;

  @HiveField(5)
  final double f3Skr0_5;

  @HiveField(6)
  final double f3Skr0_6;

  F3SkrModel({
    required this.nNo,
    required this.f3Skr0_1,
    required this.f3Skr0_2,
    required this.f3Skr0_3,
    required this.f3Skr0_4,
    required this.f3Skr0_5,
    required this.f3Skr0_6,
  });

  factory F3SkrModel.fromJson(Map<String, dynamic> json) {
    return F3SkrModel(
      nNo: json['N/No'],
      f3Skr0_1: double.parse(json['F3/Skr0.1']),
      f3Skr0_2: double.parse(json['F3/Skr0.2']),
      f3Skr0_3: double.parse(json['F3/Skr0.3']),
      f3Skr0_4: double.parse(json['F3/Skr0.4']),
      f3Skr0_5: double.parse(json['F3/Skr0.5']),
      f3Skr0_6: double.parse(json['F3/Skr0.6']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'N/No': nNo,
      'F3/Skr0.1': f3Skr0_1.toString(),
      'F3/Skr0.2': f3Skr0_2.toString(),
      'F3/Skr0.3': f3Skr0_3.toString(),
      'F3/Skr0.4': f3Skr0_4.toString(),
      'F3/Skr0.5': f3Skr0_5.toString(),
      'F3/Skr0.6': f3Skr0_6.toString(),
    };
  }

  static List<F3SkrModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => F3SkrModel.fromJson(json)).toList();
  }
}
