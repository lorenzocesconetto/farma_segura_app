import 'package:flutter/material.dart';

import './custom_text_field.dart';

Widget passwordTextFieldBuilder({
  onSaved,
  label: 'Senha',
  hintLabel: 'Defina sua senha',
  prefixIcon: Icons.lock,
  obscureText: true,
  keyboardType: TextInputType.visiblePassword,
  validator,
  iconColor: const Color.fromRGBO(255, 255, 255, 1),
  backgroundColor: const Color(0xFF6CA8F1),
  cursorColor: const Color.fromRGBO(255, 255, 255, 1),
  controller,
  textColor: const Color.fromRGBO(255, 255, 255, 1),
  hintTextColor: const Color.fromRGBO(255, 255, 255, .54),
}) {
  if (validator == null)
    validator = (value) => (value.isEmpty || value.length < 6)
        ? '  Senha deve ter 6 digitos ou mais'
        : null;
  return CustomTextField(
    onSaved: onSaved,
    label: label,
    hintLabel: hintLabel,
    prefixIcon: prefixIcon,
    obscureText: obscureText,
    keyboardType: keyboardType,
    validator: validator,
    iconColor: iconColor,
    backgroundColor: backgroundColor,
    cursorColor: cursorColor,
    controller: controller,
    textColor: textColor,
    hintTextColor: hintTextColor,
  );
}
