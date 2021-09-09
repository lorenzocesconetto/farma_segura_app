import 'package:flutter/material.dart';
// import 'package:intl/date_symbol_data_local.dart';

import 'package:farma_segura_app/models/scheduled_med_on_date.dart';
import 'package:intl/intl.dart';

class MedMessage extends StatelessWidget {
  final ScheduledMedOnDate userMed;

  MedMessage(this.userMed);

  @override
  Widget build(BuildContext context) {
    String message;
    Color color;
    final String dateString =
        DateFormat(DateFormat.ABBR_MONTH_DAY, 'pt_BR').format(userMed.dateTime);

    final bool isToday = DateTime.now().day == userMed.dateTime.day &&
        DateTime.now().month == userMed.dateTime.month &&
        DateTime.now().year == userMed.dateTime.year;
    final bool isPassed = DateTime.now().isAfter(userMed.dateTime);

    if (userMed.taken != null) {
      message = '';
      color = Colors.black26;
    } else if (isToday && isPassed) {
      message = 'Atrasado ';
      color = Colors.red;
    } else if (isPassed) {
      message = "$dateString ";
      color = Colors.red;
    } else if (DateTime.now()
        .add(Duration(minutes: 30))
        .isAfter(userMed.dateTime)) {
      message = 'Daqui a pouco ';
      color = Color.fromRGBO(190, 190, 0, 1);
    } else {
      color = Colors.green;

      if (isToday) {
        message = 'Hoje ';
      } else {
        message = "$dateString ";
      }
    }

    return Container(
      margin: EdgeInsets.only(left: 30),
      child: Center(
        child: Text(
          '$message${DateFormat(DateFormat.HOUR24_MINUTE).format(userMed.dateTime)}',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
      height: 20,
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: color,
      ),
    );
  }
}
