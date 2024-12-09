import 'package:flutter/material.dart';
import 'package:pearl/view/wellpi/widgets/wellpi_app_bar.dart';
import 'package:pearl/view/wellpi/widgets/wellpi_body.dart';
import 'package:pearl/view/widgets/custom_drawer.dart';

class WellPIScreen extends StatelessWidget {
  const WellPIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WellPIAppBar(), // Use CustomAppBar
      drawer: CustomDrawer(), // Use CustomDrawer
      body: WellPIBody(), // Use CustomBody
    );
  }
}
