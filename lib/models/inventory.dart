import 'package:flutter/material.dart';

class Inventory {
  final int id;
  final int inventory;
  final int medicationId;
  final String nomeComercial;
  final String apresentacao;

  Inventory({
    @required this.id,
    @required this.inventory,
    @required this.medicationId,
    @required this.apresentacao,
    @required this.nomeComercial,
  });

  static Inventory fromJson(jsonData) {
    return Inventory(
      id: jsonData['id'],
      inventory: jsonData['inventory'],
      medicationId: jsonData['medication']['id'],
      nomeComercial: jsonData['medication']['nome_comercial'],
      apresentacao: jsonData['medication']['apresentacao'],
    );
  }
}
