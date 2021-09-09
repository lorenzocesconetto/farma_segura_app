import 'package:flutter/material.dart';

class TimePickerField extends StatelessWidget {
  final TimeOfDay pickedTime;
  final Function setPickedTime;

  TimePickerField(this.pickedTime, this.setPickedTime);

  void _showTimePicker(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: pickedTime,
      initialEntryMode: TimePickerEntryMode.input,
    ).then((value) {
      if (value != null) setPickedTime(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: GestureDetector(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                onPressed: () => _showTimePicker(context),
                child: Text('Escolher horário')),
            Text(
              '${pickedTime.format(context)}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontSize: 20),
            ),
          ],
        ),
        onTap: () => _showTimePicker(context),
      ),
    );
  }
}
