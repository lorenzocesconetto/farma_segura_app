import 'package:flutter/material.dart';

class QuantityTakeTextField extends StatelessWidget {
  final TextEditingController controller;
  QuantityTakeTextField(this.controller);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) return 'Preencha este campo';
        return null;
      },
      controller: controller,
      autocorrect: false,
      decoration: InputDecoration(
        hintText: 'Dose a ser tomada',
        labelText: 'Número de comprimidos da dose',
        // prefixIcon: Icon(Icons.add_box),
        border: const OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
    );
  }
}
