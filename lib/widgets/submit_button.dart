import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final bool isLoading;
  final Function onPressed;
  final Color textColor;
  final Color backgroundColor;
  final String label;

  SubmitButton({
    @required this.onPressed,
    @required this.isLoading,
    this.label: 'LOGIN',
    this.textColor: const Color(0xFF527DAA),
    this.backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: isLoading
          ? CircularProgressIndicator.adaptive()
          : RaisedButton(
              elevation: 5.0,
              onPressed: onPressed,
              padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              color: backgroundColor,
              child: Text(
                label,
                style: TextStyle(
                  color: textColor,
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
    );
  }
}
