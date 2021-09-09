import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduledMed {
  final int id;
  final int quantity;
  final int medicationId;
  final String nomeComercial;
  final String apresentacao;
  final int hour;
  final int minute;
  final String message;

  ScheduledMed({
    @required this.id,
    @required this.nomeComercial,
    @required this.quantity,
    @required this.medicationId,
    @required this.apresentacao,
    @required this.hour,
    @required this.minute,
    @required this.message,
  });

  String getTime() {
    final formatter = NumberFormat('00');
    final strMinute = formatter.format(minute);
    final strHour = formatter.format(hour);
    return '$strHour:$strMinute';
  }

  static ScheduledMed fromJson(jsonData) {
    return ScheduledMed(
      id: jsonData['id'],
      quantity: jsonData['quantity'],
      nomeComercial: jsonData['medication']['nome_comercial'],
      apresentacao: jsonData['medication']['apresentacao'],
      medicationId: jsonData['medication']['id'],
      hour: jsonData['hour'],
      minute: jsonData['minute'],
      message: jsonData['message'],
    );
  }
}
