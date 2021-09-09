import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class IosScaffoldNav extends StatelessWidget {
  IosScaffoldNav({
    @required this.screens,
    @required this.titles,
    @required this.icons,
  });

  final List<Widget> screens;
  final List<String> titles;
  final List<IconData> icons;
  final List<BottomNavigationBarItem> tabs = [];

  @override
  Widget build(BuildContext context) {
    assert(screens.length == icons.length && screens.length == titles.length,
        'legth of arrays are not matching');
    for (int i = 0; i < screens.length; i++) {
      tabs.add(
        BottomNavigationBarItem(
          icon: Icon(icons[i]),
          label: titles[i],
        ),
      );
    }
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: tabs,
        activeColor: Colors.white,
        inactiveColor: Colors.white38,
        backgroundColor: Colors.black.withOpacity(.5),
      ),
      tabBuilder: (context, index) => screens[index],
    );
  }
}
