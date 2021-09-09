import 'package:flutter/material.dart';

import '../med_frequency.dart';

class FrequencyDropdown extends StatelessWidget {
  final MedFrequency _pickedFrequency;
  final Function setPickedFrequency;

  FrequencyDropdown(this.setPickedFrequency, this._pickedFrequency);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: _pickedFrequency,
      validator: (value) {
        if (value == null) return 'Selecionar uma opção';
        return null;
      },
      onChanged: setPickedFrequency,
      hint: Text('Escolha a frequencia'),
      isExpanded: true,
      items: <DropdownMenuItem>[
        DropdownMenuItem(value: MedFrequency.everyday, child: Text('Todo dia')),
        // DropdownMenuItem(value: MedFrequency.everyOtherDay, child: Text('Dia sim, dia não')),
        // DropdownMenuItem(value: MedFrequency.onceAWeek, child: Text('Uma vez por semana')),
        // DropdownMenuItem(value: MedFrequency.onceAMonth, child: Text('Uma vez por mês')),
        // DropdownMenuItem(value: MedFrequency.once, child: Text('Uma única vez')),
      ],
    );
  }
}
