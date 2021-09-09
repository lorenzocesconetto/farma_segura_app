import 'package:flutter/material.dart';

class Symptom {
  final int id;
  final int intensity;
  final DateTime markedDatetime;
  final int symptomId;
  final String symptomName;

  Symptom({
    @required this.id,
    @required this.intensity,
    @required this.markedDatetime,
    @required this.symptomId,
    @required this.symptomName,
  });

  static Symptom fromJson(jsonData) {
    return Symptom(
      id: jsonData['id'],
      intensity: jsonData['intensity'],
      markedDatetime: DateTime.parse(jsonData['marked_datetime']),
      symptomId: jsonData['symptom']['id'],
      symptomName: jsonData['symptom']['name'],
    );
  }
}
