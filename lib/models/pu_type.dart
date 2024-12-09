import 'package:hive/hive.dart';

part 'pu_type.g.dart';

@HiveType(typeId: 0)  // Each HiveType needs a unique `typeId`
class PUType {
  @HiveField(0)
  String? conventional;

  @HiveField(1)
  String? markII;

  @HiveField(2)
  String? airBalance;

  PUType({
    this.conventional,
    this.markII,
    this.airBalance,
  });
}
