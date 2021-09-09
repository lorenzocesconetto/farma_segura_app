import 'package:farma_segura_app/screen_day/widgets/date_number.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateItem extends StatelessWidget {
  DateItem(this.date);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      width: mediaQuery.size.width / 5,
      // margin: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          FittedBox(
            child: Text(
              DateFormat.E('pt_BR').format(date).toUpperCase(),
              style: TextStyle(
                color: Colors.blue,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 7),
          DateNumber(date)
        ],
      ),
    );
  }
}
