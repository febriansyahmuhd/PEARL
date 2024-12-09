import 'package:flutter/material.dart';

// Custom AppBar Widget
class WellPIAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WellPIAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Well PI',
        style: TextStyle(color: Colors.white), // Set title color to white
      ),
      backgroundColor: const Color(0xFFABC437),
      iconTheme:
          const IconThemeData(color: Colors.white), // Set icon color to white
      actions: [
        PopupMenuButton<String>(
          onSelected: (String value) {
            switch (value) {
              case 'Option 1':
                print("Option 1 selected");
                break;
              case 'Option 2':
                print("Option 2 selected");
                break;
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem<String>(
                value: 'Option 1',
                child: Text('Unit Conversion'),
              ),
              const PopupMenuItem<String>(
                value: 'Option 2',
                child: Text('Help'),
              ),
            ];
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
