import 'package:farma_segura_app/models/scheduled_med.dart';
import 'package:flutter/material.dart';

class MedicationItem extends StatelessWidget {
  final ScheduledMed e;
  final Function _deleteItem;

  MedicationItem(this.e, this._deleteItem);

  @override
  Widget build(BuildContext context) {
    return Material(
      key: ValueKey(e.id),
      child: Card(
        elevation: 3,
        child: ListTile(
          leading: Container(
            padding: EdgeInsets.all(16),
            child: Text(
              e.getTime(),
              style: TextStyle(color: Colors.white),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text("${e.nomeComercial} - ${e.apresentacao}"),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 3),
              Text('${e.message} às ${e.getTime()}'),
              SizedBox(height: 2),
              Text('Dose: ${e.quantity} comp.'),
              SizedBox(height: 5),
            ],
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () => _deleteItem(e.id),
          ),
        ),
      ),
    );
  }
}
