import 'package:flutter/material.dart';

class Medication {
  int id;
  String apresentacao;
  String nomeComercial;
  String razaoSocial;
  String principiosAtivos;

  Medication({
    @required this.id,
    @required this.nomeComercial,
    @required this.apresentacao,
    @required this.principiosAtivos,
    @required this.razaoSocial,
  });

  static Medication fromJson(jsonData) {
    return Medication(
      id: jsonData['id'],
      apresentacao: jsonData['apresentacao'],
      nomeComercial: jsonData['nome_comercial'],
      razaoSocial: jsonData['razao_social'],
      principiosAtivos: jsonData['principios_ativos'],
    );
  }
}
