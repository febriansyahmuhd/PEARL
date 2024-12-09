import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pearl/models/api.dart';
import 'package:pearl/models/f0skr.dart';
import 'package:pearl/models/f1skr.dart';
import 'package:pearl/models/f2skr.dart';
import 'package:pearl/models/f3skr.dart';
import 'package:pearl/models/nnovssps.dart';
import 'package:pearl/models/pu_type.dart';
import 'package:pearl/models/pump_constant.dart';
import 'package:pearl/models/rod_and_pump_data.dart';
import 'package:pearl/models/saveloaddata.dart';
import 'package:pearl/models/sr_api.dart';
import 'package:pearl/models/sr_data.dart';
import 'package:pearl/models/sr_grade.dart';
import 'package:pearl/models/twotskr.dart';
import 'package:pearl/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(APIAdapter());
  Hive.registerAdapter(SRDataAdapter());
  Hive.registerAdapter(PUTypeAdapter());
  Hive.registerAdapter(SRGradeAdapter());
  Hive.registerAdapter(PumpConstantAdapter());
  Hive.registerAdapter(SRAPIAdapter());
  Hive.registerAdapter(RodPumpDataAdapter());
  Hive.registerAdapter(nnovsspsAdapter());
  Hive.registerAdapter(F1SkrModelAdapter());
  Hive.registerAdapter(F2SkrModelAdapter());
  Hive.registerAdapter(F3SkrModelAdapter());
  Hive.registerAdapter(TwoTSkrModelAdapter());
  Hive.registerAdapter(F0SkrModelAdapter());
  // Hive.registerAdapter(saveloaddataAdapter());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
