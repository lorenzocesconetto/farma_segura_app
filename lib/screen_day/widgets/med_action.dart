import 'package:flutter/material.dart';

class MedAction extends StatelessWidget {
  final Color color;
  final IconData icon;
  final bool isSelected;

  MedAction(this.color, this.icon, this.isSelected);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 3),
        color: isSelected ? color : null,
      ),
      child: Center(
        child: Icon(
          icon,
          color: isSelected ? Colors.white : color,
          size: 25,
        ),
      ),
    );
  }
}
