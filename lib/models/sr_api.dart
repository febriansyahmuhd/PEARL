import 'package:hive/hive.dart';

part 'sr_api.g.dart';

@HiveType(typeId: 5) // Ensure this typeId is unique
class SR_API {
  @HiveField(0)
  int rodNo;

  SR_API({
    required this.rodNo,
  });
}
