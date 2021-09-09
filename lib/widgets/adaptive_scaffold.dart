import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveScaffold extends StatelessWidget {
  final Widget body;
  final Widget appBar;

  AdaptiveScaffold({
    @required this.body,
    @required this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        child: body,
        navigationBar: appBar,
      );
    }
    return Scaffold(
      appBar: appBar,
      body: body,
    );
  }
}
