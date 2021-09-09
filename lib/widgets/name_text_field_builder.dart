import 'package:farma_segura_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget nameTextFieldBuilder({
  onSaved,
  autocorrect: false,
  obscureText: false,
  textCapitalization: TextCapitalization.none,
  keyboardType: TextInputType.name,
  validator,
  prefixIcon: Icons.text_format,
  label: 'Primeiro nome',
  hintLabel: 'Primeiro nome',
  iconColor: const Color.fromRGBO(0, 0, 0, .54),
  backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
  cursorColor: const Color.fromRGBO(0, 0, 0, .54),
  controller,
  textColor: const Color.fromRGBO(0, 0, 0, .54),
  hintTextColor: const Color.fromRGBO(0, 0, 0, .26),
  List<TextInputFormatter> inputFormatters,
}) {
  if (validator == null) {
    validator = (value) => value.isEmpty || value.length < 3
        ? 'Deve ter pelo menos 3 caracteres'
        : null;
  }
  return CustomTextField(
    inputFormatters: inputFormatters,
    textCapitalization: textCapitalization,
    autocorrect: autocorrect,
    onSaved: onSaved,
    obscureText: obscureText,
    keyboardType: keyboardType,
    validator: validator,
    prefixIcon: prefixIcon,
    label: label,
    hintLabel: hintLabel,
    iconColor: iconColor,
    backgroundColor: backgroundColor,
    cursorColor: cursorColor,
    controller: controller,
    textColor: textColor,
    hintTextColor: hintTextColor,
  );
}
