import 'package:flutter/material.dart';

class UnderBarIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;

  const UnderBarIcon({
    super.key,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(width: 3, color: iconColor)),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: iconColor,
            ),
          ],
        ),
      ),
    );
  }
}
