import 'package:flutter/material.dart';

void errorDialogBuilder({
  String title: 'Ocorreu um erro',
  String message: 'Tente novamente mais tarde',
  @required BuildContext context,
}) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: Text('Ok'),
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        )
      ],
    ),
  );
}
