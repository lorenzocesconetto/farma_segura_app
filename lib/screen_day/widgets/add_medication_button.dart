import 'package:farma_segura_app/screen_add_medication/main.dart';
import 'package:flutter/material.dart';

class AddMedicationButton extends StatelessWidget {
  final Function toggleRefreshDummy;

  AddMedicationButton(this.toggleRefreshDummy);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(ScreenAddMedication.routeName)
          .then((_) => toggleRefreshDummy()),
      child: Container(
        margin: EdgeInsets.only(top: 30),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 2,
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 2,
                offset: Offset(2, 2)),
          ],
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
