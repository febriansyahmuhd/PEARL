import 'package:hive/hive.dart';

part 'f2skr.g.dart';

@HiveType(typeId: 9) // Assign a unique typeId for Hive
class F2SkrModel {
  @HiveField(0)
  final String nNo;

  @HiveField(1)
  final double f2Skr0_1;

  @HiveField(2)
  final double f2Skr0_2;

  @HiveField(3)
  final double f2Skr0_3;

  @HiveField(4)
  final double f2Skr0_4;

  @HiveField(5)
  final double f2Skr0_5;

  F2SkrModel({
    required this.nNo,
    required this.f2Skr0_1,
    required this.f2Skr0_2,
    required this.f2Skr0_3,
    required this.f2Skr0_4,
    required this.f2Skr0_5,
  });

  factory F2SkrModel.fromJson(Map<String, dynamic> json) {
    return F2SkrModel(
      nNo: json['N/No'],
      f2Skr0_1: double.parse(json['F2/Skr0.1']),
      f2Skr0_2: double.parse(json['F2/Skr0.2']),
      f2Skr0_3: double.parse(json['F2/Skr0.3']),
      f2Skr0_4: double.parse(json['F2/Skr0.4']),
      f2Skr0_5: double.parse(json['F2/Skr0.5']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'N/No': nNo,
      'F2/Skr0.1': f2Skr0_1.toString(),
      'F2/Skr0.2': f2Skr0_2.toString(),
      'F2/Skr0.3': f2Skr0_3.toString(),
      'F2/Skr0.4': f2Skr0_4.toString(),
      'F2/Skr0.5': f2Skr0_5.toString(),
    };
  }

  static List<F2SkrModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => F2SkrModel.fromJson(json)).toList();
  }
}
