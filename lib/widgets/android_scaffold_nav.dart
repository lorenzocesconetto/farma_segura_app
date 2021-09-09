import 'package:flutter/material.dart';

class AndroidScaffoldNav extends StatefulWidget {
  AndroidScaffoldNav({
    @required this.screens,
    @required this.titles,
    @required this.icons,
  });

  final List<Widget> screens;
  final List<String> titles;
  final List<IconData> icons;

  @override
  _AndroidScaffoldNavState createState() => _AndroidScaffoldNavState();
}

class _AndroidScaffoldNavState extends State<AndroidScaffoldNav> {
  var _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    assert(
        widget.screens.length == widget.icons.length &&
            widget.screens.length == widget.titles.length,
        'legth of arrays are not matching');

    final List<BottomNavigationBarItem> bottomNavItems = [];
    for (var i = 0; i < widget.screens.length; i++) {
      bottomNavItems.add(
        BottomNavigationBarItem(
          label: widget.titles[i],
          icon: Icon(widget.icons[i]),
          // backgroundColor: Color.fromRGBO(245, 245, 245, 1),
        ),
      );
    }
    return Scaffold(
      body: widget.screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.blue.withOpacity(.3),
        selectedItemColor: Colors.blue,
        currentIndex: _selectedIndex,
        items: bottomNavItems,
        onTap: _onItemTapped,
      ),
    );
  }
}
