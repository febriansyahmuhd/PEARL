import 'package:flutter/material.dart';

class RowContent extends StatelessWidget {
  final String leftTitle;
  final String rightTitle;
  final Color leftColor;
  final Color rightColor;
  final String leftIcon;
  final String rightIcon;
  final VoidCallback onLeftTap;
  final VoidCallback onRightTap;

  RowContent({
    required this.leftTitle,
    required this.rightTitle,
    required this.leftColor,
    required this.rightColor,
    required this.leftIcon,
    required this.rightIcon,
    required this.onLeftTap,
    required this.onRightTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onLeftTap,
            child: Container(
              height: MediaQuery.of(context).size.height / 4,
              color: leftColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(leftIcon),
                  const SizedBox(height: 10),
                  Text(
                    leftTitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: onRightTap,
            child: Container(
              height: MediaQuery.of(context).size.height / 4,
              color: rightColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  rightIcon.isNotEmpty
                      ? Image.asset(rightIcon)
                      : const SizedBox(height: 20, width: 20),
                  const SizedBox(height: 10),
                  Text(
                    rightTitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
