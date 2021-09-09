import 'package:flutter/material.dart';

enum Starting { today, tomorrow }

class TodayTomorrowRadios extends StatefulWidget {
  @override
  _TodayTomorrowRadiosState createState() => _TodayTomorrowRadiosState();
}

class _TodayTomorrowRadiosState extends State<TodayTomorrowRadios> {
  var selectedStarting = Starting.today;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        width: constraints.maxWidth,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Início:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 18,
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: const Text('Hoje'),
                    value: Starting.today,
                    groupValue: selectedStarting,
                    onChanged: (value) =>
                        setState(() => selectedStarting = value),
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: const Text('Amanhã'),
                    value: Starting.tomorrow,
                    groupValue: selectedStarting,
                    onChanged: (value) =>
                        setState(() => selectedStarting = value),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
