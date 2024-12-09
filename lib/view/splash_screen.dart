import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pearl/services/srp_formula.dart';
import 'package:pearl/view/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigating to home screen after loading all data
    Timer(const Duration(seconds: 3), () async {
      SRPFunction srpData = SRPFunction();

      await Future.wait([
        srpData.initializePUType(),
        srpData.initializeSRGrade(),
        srpData.initializePumpConstant(),
        srpData.initializeAPI(),
        srpData.initializeSRData(),
        srpData.initializeSRAPI(),
        srpData.initializeRodPumpData(),
        srpData.initializeNnovssps(),
        srpData.initializeF1SkrData(),
        srpData.initializeF2SkrData(),
        srpData.initializeF3SkrData(),
        srpData.initializeTwoTSkrData(),
        srpData.initializeF0SkrData(),
      ]);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => HomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Spacer(flex: 2),
              Image.asset("assets/img/logoperlnew.png"),
              const Text(
                "Petroleum Engineering Application",
                style: TextStyle(fontSize: 20),
              ),
              Spacer(flex: 2),
              const Text(
                "Copyright xx | xx | xx",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Version X.X",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
