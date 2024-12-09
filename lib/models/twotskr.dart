import 'package:hive/hive.dart';

part 'twotskr.g.dart';

@HiveType(typeId: 11) // Assign a unique typeId for Hive
class TwoTSkrModel {
  @HiveField(0)
  final String nNo;

  @HiveField(1)
  final double tSkr0_1;

  @HiveField(2)
  final double tSkr0_2;

  @HiveField(3)
  final double tSkr0_3;

  @HiveField(4)
  final double tSkr0_4;

  @HiveField(5)
  final double tSkr0_5;

  TwoTSkrModel({
    required this.nNo,
    required this.tSkr0_1,
    required this.tSkr0_2,
    required this.tSkr0_3,
    required this.tSkr0_4,
    required this.tSkr0_5,
  });

  factory TwoTSkrModel.fromJson(Map<String, dynamic> json) {
    return TwoTSkrModel(
      nNo: json['N/No'],
      tSkr0_1: double.parse(json['2T/S2kr0.1']),
      tSkr0_2: double.parse(json['2T/S2kr0.2']),
      tSkr0_3: double.parse(json['2T/S2kr0.3']),
      tSkr0_4: double.parse(json['2T/S2kr0.4']),
      tSkr0_5: double.parse(json['2T/S2kr0.5']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'N/No': nNo,
      '2T/S2kr0.1': tSkr0_1.toString(),
      '2T/S2kr0.2': tSkr0_2.toString(),
      '2T/S2kr0.3': tSkr0_3.toString(),
      '2T/S2kr0.4': tSkr0_4.toString(),
      '2T/S2kr0.5': tSkr0_5.toString(),
    };
  }

  static List<TwoTSkrModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TwoTSkrModel.fromJson(json)).toList();
  }
}
