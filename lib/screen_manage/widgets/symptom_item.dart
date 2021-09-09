import 'package:farma_segura_app/models/symptom.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SymptomItem extends StatelessWidget {
  Symptom _symptom;
  Function _deleteItem;

  SymptomItem(this._symptom, this._deleteItem);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: Text(
            "${_symptom.intensity}",
            style: TextStyle(color: Colors.white),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(_symptom.symptomName),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 3),
            Text(DateFormat(DateFormat.MONTH_DAY, 'pt_BR')
                .format(_symptom.markedDatetime)),
            SizedBox(height: 2),
            Text('Intensidade: ${_symptom.intensity}'),
            SizedBox(height: 4)
          ],
        ),
        trailing: IconButton(
          onPressed: () => _deleteItem(_symptom.id),
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
