import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintLabel;
  final Function onSaved;
  final Color backgroundColor;
  final Color iconColor;
  final Color cursorColor;
  final Color textColor;
  final Color hintTextColor;
  final TextEditingController controller;
  final IconData prefixIcon;
  final Function validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final List<TextInputFormatter> inputFormatters;
  final bool autocorrect;
  final TextCapitalization textCapitalization;

  CustomTextField({
    this.onSaved,
    this.obscureText: false,
    @required this.keyboardType,
    @required this.validator,
    @required this.prefixIcon,
    @required this.label,
    @required this.hintLabel,
    this.controller,
    this.textCapitalization: TextCapitalization.none,
    this.hintTextColor: Colors.black26,
    this.backgroundColor: Colors.white,
    this.cursorColor: Colors.black54,
    this.textColor: Colors.black54,
    this.iconColor: Colors.black54,
    this.inputFormatters,
    this.autocorrect: true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          height: 60.0,
          child: TextFormField(
            textCapitalization: textCapitalization,
            autocorrect: autocorrect,
            inputFormatters: inputFormatters,
            obscureText: obscureText,
            controller: controller,
            cursorColor: cursorColor,
            validator: validator,
            onSaved: onSaved,
            keyboardType: keyboardType,
            style: TextStyle(
              color: textColor,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              errorStyle: TextStyle(
                color: Color(0xFFFFBB33),
                fontSize: 16,
                // fontWeight: FontWeight.bold,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                prefixIcon,
                color: iconColor,
              ),
              hintText: hintLabel,
              hintStyle: TextStyle(
                color: hintTextColor,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
