import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'android_scaffold_nav.dart';
import 'ios_scaffold_nav.dart';

class AdaptiveScaffoldNav extends StatelessWidget {
  static const routeName = '/';

  AdaptiveScaffoldNav({
    @required this.screens,
    @required this.titles,
    @required this.icons,
  });
  List<Widget> screens;
  List<String> titles;
  List<IconData> icons;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? IosScaffoldNav(
            screens: screens,
            titles: titles,
            icons: icons,
          )
        : AndroidScaffoldNav(
            screens: screens,
            titles: titles,
            icons: icons,
          );
  }
}
