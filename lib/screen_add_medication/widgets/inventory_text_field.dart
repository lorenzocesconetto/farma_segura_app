import 'package:flutter/material.dart';

class InventoryTextField extends StatelessWidget {
  final TextEditingController controller;

  InventoryTextField(this.controller);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autocorrect: false,
      decoration: InputDecoration(
        labelText: 'Número de comprimidos até acabar a caixa',
        hintText: 'Estoque',
        border: const OutlineInputBorder(),
        // prefixIcon: Icon(Icons.inventory),
      ),
      keyboardType: TextInputType.number,
    );
  }
}
