import 'package:flutter/material.dart';

// Custom Drawer Widget
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Sidebar Sections',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              // Navigate to settings page
              Navigator.pop(context); // Close the drawer
            },
          ),
          DrawerSection(
            sectionTitle: 'IPR - Inflow Performance',
            items: [
              DrawerItem(
                route: "WellPIScreen",
                icon: "assets/img/icon_well_pi_blk.png",
                title: 'Well PI',
              ),
              DrawerItem(
                  route: "",
                  icon: "assets/img/icon_swab_blk.png",
                  title: 'Swab'),
              DrawerItem(
                  route: "",
                  icon: "assets/img/icon_sonolog_blk.png",
                  title: 'Sonolog'),
              DrawerItem(
                  route: "",
                  icon: "assets/img/icon_3phase_blk.png",
                  title: '3 Phase'),
            ],
          ),
          DrawerSection(
            sectionTitle: 'Design Lifting',
            items: [
              DrawerItem(
                  route: "SRPScreen",
                  icon: "assets/img/icon_srp_blk.png",
                  title: 'SRP'),
              DrawerItem(
                  route: "", icon: "assets/img/icon_esp_blk.png", title: 'ESP'),
              DrawerItem(
                  route: "", icon: "assets/img/icon_hpu_blk.png", title: 'HPU'),
              DrawerItem(
                  route: "",
                  icon: "assets/img/icon_gas_lift_blk.png",
                  title: 'Gas Lift'),
            ],
          ),
          DrawerSection(
            sectionTitle: 'Other',
            items: [
              DrawerItem(
                  route: "",
                  icon: "assets/img/icon_interpolation_blk.png",
                  title: 'Interpolation'),
              DrawerItem(
                  route: "",
                  icon: "assets/img/icon_interpolation_blk.png",
                  title: 'Unit Convert'),
            ],
          ),
        ],
      ),
    );
  }
}

// Drawer Section Widget
// Drawer Section Widget
class DrawerSection extends StatelessWidget {
  final String sectionTitle;
  final List<DrawerItem> items;

  DrawerSection({required this.sectionTitle, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            sectionTitle,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        Column(
          children: items.map((item) {
            return Column(
              children: [
                ListTile(
                  leading: Image.asset(
                    item.icon,
                    width: 24,
                    height: 24,
                  ),
                  title: Text(item.title),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    _handleDrawerItemTap(context, item.route);
                  },
                ),
                const Divider(thickness: 1),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  void _handleDrawerItemTap(BuildContext context, String route) {
    if (route.isNotEmpty) {
      // Navigate to the specified route if it's not empty
      Navigator.pushNamed(context, route);
    } else {
      // If the route is empty, show a dialog or perform another action
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Coming Soon"),
            content: const Text("This feature is not available yet."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }
}

// Drawer Item Widget
class DrawerItem {
  final String icon;
  final String title;
  final String route;

  DrawerItem({required this.route, required this.icon, required this.title});
}
