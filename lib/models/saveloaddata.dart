import 'package:hive/hive.dart';
import 'dart:convert';

part 'saveloaddata.g.dart';

@HiveType(typeId: 12)
class saveloaddata extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String wellName;

  @HiveField(2)
  String date;

  @HiveField(3)
  String selectedRodNo;

  @HiveField(4)
  String selectedTubingSize;

  @HiveField(5)
  String selectedPlungerDiameter;

  @HiveField(6)
  String selectedApiGrade;

  @HiveField(7)
  String selectedTensileStrength;

  @HiveField(8)
  String selectedPUType;

  @HiveField(9)
  String selectedPUTypeval;

  @HiveField(10)
  String selectedElasticConstant;

  @HiveField(11)
  String pd;

  @HiveField(12)
  String smg;

  @HiveField(13)
  String fsg;

  @HiveField(14)
  String pe;

  @HiveField(15)
  String sf;

  @HiveField(16)
  String sl;

  @HiveField(17)
  String ps;

  saveloaddata({
    required this.name,
    required this.wellName,
    required this.date,
    required this.selectedRodNo,
    required this.selectedTubingSize,
    required this.selectedPlungerDiameter,
    required this.selectedApiGrade,
    required this.selectedTensileStrength,
    required this.selectedPUType,
    required this.selectedPUTypeval,
    required this.selectedElasticConstant,
    required this.pd,
    required this.smg,
    required this.fsg,
    required this.pe,
    required this.sf,
    required this.sl,
    required this.ps,
  });

  factory saveloaddata.fromJson(Map<String, dynamic> json) {
    return saveloaddata(
      name: json['name'],
      wellName: json['wellName'],
      date: json['date'],
      selectedRodNo: json['selectedRodNo'],
      selectedTubingSize: json['selectedTubingSize'],
      selectedPlungerDiameter: json['selectedPlungerDiameter'],
      selectedApiGrade: json['selectedApiGrade'],
      selectedTensileStrength: json['selectedTensileStrength'],
      selectedPUType: json['selectedPUType'],
      selectedPUTypeval: json['selectedPUTypeval'],
      selectedElasticConstant: json['selectedElasticConstant'],
      pd: json['pd'],
      smg: json['smg'],
      fsg: json['fsg'],
      pe: json['pe'],
      sf: json['sf'],
      sl: json['sl'],
      ps: json['ps'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'wellName': wellName,
      'date': date,
      'selectedRodNo': selectedRodNo,
      'selectedTubingSize': selectedTubingSize,
      'selectedPlungerDiameter': selectedPlungerDiameter,
      'selectedApiGrade': selectedApiGrade,
      'selectedTensileStrength': selectedTensileStrength,
      'selectedPUType': selectedPUType,
      'selectedPUTypeval': selectedPUTypeval,
      'selectedElasticConstant': selectedElasticConstant,
      'pd': pd,
      'smg': smg,
      'fsg': fsg,
      'pe': pe,
      'sf': sf,
      'sl': sl,
      'ps': ps,
    };
  }

  static List<saveloaddata> fromJsonList(String jsonString) {
    final data = json.decode(jsonString) as List;
    return data.map((item) => saveloaddata.fromJson(item)).toList();
  }

  static String toJsonList(List<saveloaddata> dataList) {
    final data = dataList.map((item) => item.toJson()).toList();
    return json.encode(data);
  }
}