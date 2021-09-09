import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/adaptive_appbar.dart';
import '../widgets/adaptive_scaffold.dart';
import '../providers/inventories.dart';
import '../providers/profiles.dart';
import '../providers/scheduled_medications.dart';
import '../widgets/error_dialog_builder.dart';
import '../screen_add_medication/widgets/today_tomorrow_radios.dart';
import './widgets/inventory_text_field.dart';
import './widgets/quantity_take_text_field.dart';
import './med_frequency.dart';
import './widgets/frequecy_dropdown.dart';
import './widgets/medication_text_field.dart';
import './widgets/timepicker_field.dart';

class ScreenAddMedication extends StatefulWidget {
  static const routeName = 'add_medication';

  @override
  _ScreenAddMedicationState createState() => _ScreenAddMedicationState();
}

class _ScreenAddMedicationState extends State<ScreenAddMedication> {
  final _form = GlobalKey<FormState>();
  final _medicationNameController = TextEditingController();
  int _pickedMedicationId;
  final _quantityController = TextEditingController();
  final _inventoryController = TextEditingController();
  MedFrequency _pickedFrequency = MedFrequency.everyday;
  TimeOfDay _pickedTime = TimeOfDay.now();

  void _saveForm() async {
    if (!_form.currentState.validate()) return;
    final selectedProfileId =
        Provider.of<Profiles>(context, listen: false).selectedProfileId;
    final response =
        Provider.of<ScheduledMedications>(context, listen: false).addItem(
      medicationId: _pickedMedicationId,
      inventory: _inventoryController.text.isEmpty
          ? null
          : int.parse(_inventoryController.text),
      profileId: selectedProfileId,
      frequency: _pickedFrequency,
      time: _pickedTime,
      quantity: int.parse(_quantityController.text),
    );
    if (response != null) {
      Provider.of<Inventories>(context, listen: false)
          .fetchAndSet(selectedProfileId);
      Navigator.of(context).pop();
    } else {
      errorDialogBuilder(
          context: context, message: 'Tente novamente mais tarde.');
    }
  }

  void setPickedMedicationId(int value) {
    setState(() => _pickedMedicationId = value);
  }

  void setPickedTime(dynamic value) {
    setState(() => _pickedTime = value);
  }

  void setPickedFrequency(dynamic newMedFrequency) {
    setState(() => _pickedFrequency = newMedFrequency);
  }

  List<Widget> _buildForm() {
    if (_pickedFrequency == null) {
      return [];
    } else if (_pickedFrequency == MedFrequency.everyday) {
      return [TimePickerField(_pickedTime, setPickedTime)];
    } else if (_pickedFrequency == MedFrequency.everyOtherDay) {
      return [
        TimePickerField(_pickedTime, setPickedTime),
        TodayTomorrowRadios()
      ];
    } else if (_pickedFrequency == MedFrequency.onceAWeek) {
      return [TimePickerField(_pickedTime, setPickedTime)];
    } else if (_pickedFrequency == MedFrequency.onceAMonth) {
      return [TimePickerField(_pickedTime, setPickedTime)];
    } else if (_pickedFrequency == MedFrequency.once) {
      return [TimePickerField(_pickedTime, setPickedTime)];
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      appBar: AdaptiveAppBarBuilder('Nova medicação'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Material(
              child: Column(
                children: [
                  MedicationTextField(_medicationNameController,
                      _pickedMedicationId, setPickedMedicationId),
                  SizedBox(height: 20),
                  FrequencyDropdown(setPickedFrequency, _pickedFrequency),
                  SizedBox(height: 40),
                  QuantityTakeTextField(_quantityController),
                  SizedBox(height: 40),
                  InventoryTextField(_inventoryController),
                  ..._buildForm(),
                  ElevatedButton(
                    onPressed: _saveForm,
                    child: Text('Cadastrar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
