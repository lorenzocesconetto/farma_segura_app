import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// return CupertinoSliverNavigationBar(middle: Text(title));
// CupertinoNavigationBar(middle: Text(title));
PreferredSizeWidget AdaptiveAppBarBuilder(String label) {
  if (Platform.isIOS)
    return CupertinoNavigationBar(
      middle: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  return AppBar(title: Text(label));
}
