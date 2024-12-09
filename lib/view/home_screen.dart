import 'package:flutter/material.dart';

import 'widgets/custom_app_bar.dart'; // Import Custom Widgets
import 'widgets/custom_body.dart';
import 'widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(), // Use CustomAppBar
      drawer: CustomDrawer(), // Use CustomDrawer
      body: CustomBody(), // Use CustomBody
    );
  }
}
