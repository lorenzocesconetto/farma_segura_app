import 'package:farma_segura_app/providers/selected_date.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DateNumber extends StatelessWidget {
  final DateTime date;

  DateNumber(this.date);

  @override
  Widget build(BuildContext context) {
    final selectedDateProvider = Provider.of<SelectedDate>(context);
    final bool isActive = selectedDateProvider.isSelected(date);
    final linerGradient = isActive
        ? LinearGradient(
            colors: [
              Colors.green,
              Colors.blue,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
        : null;
    final textStyle = isActive
        ? TextStyle(
            color: Colors.white,
            fontSize: 22,
          )
        : TextStyle(
            color: Colors.black54,
            fontSize: 22,
          );

    return GestureDetector(
      onTap: () => selectedDateProvider.setDate(date),
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: linerGradient,
        ),
        child: FittedBox(
          child: Text(
            '${date.day}',
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
