import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:cpfcnpj/cpfcnpj.dart';

import './custom_text_field.dart';

Widget cpfTextFieldBuilder({
  onSaved,
  obscureText: false,
  keyboardType: TextInputType.number,
  validator,
  prefixIcon: Icons.perm_identity,
  label: 'CPF',
  hintLabel: '000.000.000-00',
  iconColor: const Color.fromRGBO(0, 0, 0, .54),
  backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
  cursorColor: const Color.fromRGBO(0, 0, 0, .54),
  controller,
  textColor: const Color.fromRGBO(0, 0, 0, .54),
  hintTextColor: const Color.fromRGBO(0, 0, 0, .26),
}) {
  final maskCpf = MaskTextInputFormatter(
      mask: "###.###.###-##", filter: {"#": RegExp(r'[0-9]')});

  if (validator == null)
    validator = (value) => CPF.isValid(value) ? null : '  CPF inválido';
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
    inputFormatters: [maskCpf],
  );
}
