import 'package:flutter/material.dart';

// Custom AppBar Widget
class SRPAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function() onSave;

  const SRPAppBar({super.key, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'SRP DESIGN',
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
                child: Text('Save As'),
              ),
              const PopupMenuItem<String>(
                value: 'Option 2',
                child: Text('Save'),
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
