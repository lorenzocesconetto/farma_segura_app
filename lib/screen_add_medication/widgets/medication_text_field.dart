import 'package:farma_segura_app/providers/backend_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

import '../../models/medication.dart';

class MedicationTextField extends StatefulWidget {
  TextEditingController medicationNameController;
  Function setPickedMedicationId;
  int _pickedMedicationId;

  MedicationTextField(this.medicationNameController, this._pickedMedicationId,
      this.setPickedMedicationId);

  @override
  _MedicationTextFieldState createState() => _MedicationTextFieldState();
}

class _MedicationTextFieldState extends State<MedicationTextField> {
  var _hasTyped = false;

  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField<Medication>(
      validator: (value) {
        if (widget._pickedMedicationId == null)
          return 'Escolha um medicamento da lista de sugestões';
        return null;
      },
      hideSuggestionsOnKeyboardHide: false,
      debounceDuration: const Duration(milliseconds: 600),
      textFieldConfiguration: TextFieldConfiguration(
        onChanged: (value) {
          widget.setPickedMedicationId(null);
          _hasTyped = true;
        },
        controller: widget.medicationNameController,
        autocorrect: false,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          icon: _hasTyped == false
              ? null
              : widget._pickedMedicationId == null
                  ? Icon(Icons.cancel)
                  : Icon(Icons.check_circle),
          border: OutlineInputBorder(),
          hintText: 'Medicação',
        ),
      ),
      noItemsFoundBuilder: (context) => ListTile(
        title: Text('Medicamento não encontrado'),
      ),
      suggestionsCallback: (query) async {
        return await Provider.of<BackendApi>(context, listen: false)
            .getAutocompleteSuggestions(query, 10);
      },
      itemBuilder: (BuildContext context, Medication suggestion) => ListTile(
        title: Text(
          suggestion.nomeComercial,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          suggestion.apresentacao,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      onSuggestionSelected: (suggestion) {
        widget.setPickedMedicationId(suggestion.id);
        widget.medicationNameController.text =
            "${suggestion.nomeComercial} - ${suggestion.apresentacao}";
      },
    );
  }
}
