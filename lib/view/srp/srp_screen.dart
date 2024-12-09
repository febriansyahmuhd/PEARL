import 'package:flutter/material.dart';
import 'package:pearl/view/srp/widgets/srp_app_bar.dart';
import 'package:pearl/view/srp/widgets/srp_body.dart';
import 'package:pearl/view/widgets/custom_drawer.dart';

class SRPScreen extends StatefulWidget {
  const SRPScreen({super.key});

  @override
  _SRPScreenState createState() => _SRPScreenState();
}

class _SRPScreenState extends State<SRPScreen> {
  Map<String, dynamic> data = {};

  void updateData(Map<String, dynamic> newData) {
    setState(() {
      data = newData;
    });
  }

  void saveData() {
    // Implement your saveData logic here
    print("Data saved: $data");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SRPAppBar(onSave: saveData), // Use CustomAppBar
      drawer: CustomDrawer(), // Use CustomDrawer
      body: SRPBody(onDataChanged: updateData), // Use CustomBody
    );
  }
}
