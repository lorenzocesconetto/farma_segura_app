import 'package:farma_segura_app/providers/backend_api.dart';
import 'package:farma_segura_app/providers/profiles.dart';
// import 'package:farma_segura_app/screen_symptoms/widgets/intensity_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

enum SaveSymptomState {
  editing,
  loading,
  successful,
}

class NewSymptomForm extends StatefulWidget {
  final String title;
  final int symptomId;

  NewSymptomForm(this.title, this.symptomId);

  @override
  _NewSymptomFormState createState() => _NewSymptomFormState();
}

class _NewSymptomFormState extends State<NewSymptomForm> {
  double _currentSliderValue = 1;
  var _dateTime = DateTime.now();
  final _maximumDate = DateTime.now();
  final _minimumDate = DateTime.now().add(Duration(days: -7));
  var _saveSymptomState = SaveSymptomState.editing;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      padding: EdgeInsets.only(
        bottom: 10 + mediaQuery.viewInsets.bottom,
        top: 10,
        left: 10,
        right: 10,
      ),
      child: Column(
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Intensidade do sintoma (de 1 à 4)',
            style: TextStyle(fontSize: 16),
          ),
          Slider.adaptive(
              value: _currentSliderValue,
              min: 1,
              max: 4,
              divisions: 3,
              label: _currentSliderValue.round().toString(),
              onChanged: (double value) {
                setState(() => _currentSliderValue = value);
              }),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => CupertinoDatePicker(
                  minimumYear: _minimumDate.year,
                  maximumYear: _maximumDate.year,
                  maximumDate: _maximumDate,
                  minimumDate: _minimumDate,
                  initialDateTime: _dateTime,
                  onDateTimeChanged: (value) {
                    if (value.isAfter(_maximumDate))
                      value = _maximumDate;
                    else if (value.isBefore(_minimumDate)) value = _minimumDate;
                    setState(() => _dateTime = value);
                  },
                  mode: CupertinoDatePickerMode.date,
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.07),
                border: Border.all(color: Colors.black87),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(DateFormat.MMMMEEEEd('pt_BR').format(_dateTime)),
            ),
          ),
          SizedBox(height: 20),
          if (_saveSymptomState == SaveSymptomState.loading)
            CircularProgressIndicator(),
          if (_saveSymptomState == SaveSymptomState.successful)
            Container(
              padding: EdgeInsets.all(5),
              height: 55,
              child: Icon(
                Icons.check,
                color: Colors.green,
                size: 35,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.green, width: 3),
              ),
            ),
          if (_saveSymptomState == SaveSymptomState.editing)
            ElevatedButton(
              child: Text('Salvar'),
              onPressed: () async {
                setState(() => _saveSymptomState = SaveSymptomState.loading);
                await Provider.of<BackendApi>(context, listen: false)
                    .saveSymptom(
                  date: _dateTime,
                  symptomId: widget.symptomId,
                  intensity: _currentSliderValue.round(),
                  profileId: Provider.of<Profiles>(context, listen: false)
                      .selectedProfileId,
                );
                setState(() => _saveSymptomState = SaveSymptomState.successful);
                await Future.delayed(const Duration(seconds: 1));
                Navigator.of(context).pop();
              },
            ),
        ],
      ),
    );
  }
}
