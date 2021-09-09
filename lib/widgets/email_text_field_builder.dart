import 'package:flutter/material.dart';

import './custom_text_field.dart';
import 'package:email_validator/email_validator.dart';

Widget emailTextFieldBuilder({
  onSaved,
  obscureText: false,
  keyboardType: TextInputType.emailAddress,
  validator,
  prefixIcon: Icons.email,
  label: 'Email',
  hintLabel: 'Digite seu Email',
  iconColor: const Color.fromRGBO(255, 255, 255, 1),
  backgroundColor: const Color(0xFF6CA8F1),
  cursorColor: const Color.fromRGBO(255, 255, 255, 1),
  controller,
  textColor: const Color.fromRGBO(255, 255, 255, 1),
  hintTextColor: const Color.fromRGBO(255, 255, 255, .54),
}) {
  if (validator == null)
    validator = (String value) {
      value = value.toLowerCase().trim();
      return EmailValidator.validate(value) ? null : '  Email inválido';
    };
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
