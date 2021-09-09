import 'package:flutter/material.dart';

class ScheduledMedOnDate {
  final int id;
  final String nomeComercial;
  final String apresentacao;
  final int quantity;
  final DateTime dateTime;
  final int medicationId;
  bool taken;
  int inventory;

  ScheduledMedOnDate({
    @required this.id,
    @required this.nomeComercial,
    @required this.apresentacao,
    @required this.quantity,
    @required this.dateTime,
    @required this.taken,
    @required this.medicationId,
    @required this.inventory,
  });

  static ScheduledMedOnDate fromJson(Map jsonData) {
    return ScheduledMedOnDate(
      id: jsonData['id'],
      quantity: jsonData['quantity'],
      nomeComercial: jsonData['medication']['nome_comercial'],
      apresentacao: jsonData['medication']['apresentacao'],
      medicationId: jsonData['medication']['id'],
      dateTime: DateTime.parse(jsonData['original_timestamp']),
      taken: jsonData['taken'],
      inventory:
          jsonData['inventory'] == null ? null : jsonData['inventory'].round(),
    );
  }
}
