import 'package:hive/hive.dart';

part 'f0skr.g.dart';

@HiveType(typeId: 12) // Assign a unique typeId for Hive
class F0SkrModel {
  @HiveField(0)
  final String nNo;

  @HiveField(1)
  final double f0Skr15;

  @HiveField(2)
  final double f0Skr10;

  @HiveField(3)
  final double f0Skr7_5;

  @HiveField(4)
  final double f0Skr5;

  @HiveField(5)
  final double f0Skr3;

  @HiveField(6)
  final double f0Skr1_5;

  @HiveField(7)
  final double f0Skr1;

  @HiveField(8)
  final double f0Skr0;

  @HiveField(9)
  final double f0Skr_1_75;

  @HiveField(10)
  final double f0Skr_1_75_2;

  @HiveField(11)
  final double f0Skr0_2;

  @HiveField(12)
  final double f0Skr1_2;

  @HiveField(13)
  final double f0Skr1_5_2;

  F0SkrModel({
    required this.nNo,
    required this.f0Skr15,
    required this.f0Skr10,
    required this.f0Skr7_5,
    required this.f0Skr5,
    required this.f0Skr3,
    required this.f0Skr1_5,
    required this.f0Skr1,
    required this.f0Skr0,
    required this.f0Skr_1_75,
    required this.f0Skr_1_75_2,
    required this.f0Skr0_2,
    required this.f0Skr1_2,
    required this.f0Skr1_5_2,
  });

  factory F0SkrModel.fromJson(Map<String, dynamic> json) {
    return F0SkrModel(
      nNo: json['N/No'],
      f0Skr15: double.parse(json['F0/Skr15']),
      f0Skr10: double.parse(json['F0/Skr10']),
      f0Skr7_5: double.parse(json['F0/Skr7.5']),
      f0Skr5: double.parse(json['F0/Skr5']),
      f0Skr3: double.parse(json['F0/Skr3']),
      f0Skr1_5: double.parse(json['F0/Skr1.5']),
      f0Skr1: double.parse(json['F0/Skr1']),
      f0Skr0: double.parse(json['F0/Skr0']),
      f0Skr_1_75: double.parse(json['F0/Skr-1.75']),
      f0Skr_1_75_2: double.parse(json['F0/Skr-1.75(2)']),
      f0Skr0_2: double.parse(json['F0/Skr0(2)']),
      f0Skr1_2: double.parse(json['F0/Skr1(2)']),
      f0Skr1_5_2: double.parse(json['F0/Skr1.5(2)']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'N/No': nNo,
      'F0/Skr15': f0Skr15.toString(),
      'F0/Skr10': f0Skr10.toString(),
      'F0/Skr7.5': f0Skr7_5.toString(),
      'F0/Skr5': f0Skr5.toString(),
      'F0/Skr3': f0Skr3.toString(),
      'F0/Skr1.5': f0Skr1_5.toString(),
      'F0/Skr1': f0Skr1.toString(),
      'F0/Skr0': f0Skr0.toString(),
      'F0/Skr-1.75': f0Skr_1_75.toString(),
      'F0/Skr-1.75(2)': f0Skr_1_75_2.toString(),
      'F0/Skr0(2)': f0Skr0_2.toString(),
      'F0/Skr1(2)': f0Skr1_2.toString(),
      'F0/Skr1.5(2)': f0Skr1_5_2.toString(),
    };
  }

  static List<F0SkrModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => F0SkrModel.fromJson(json)).toList();
  }
}
