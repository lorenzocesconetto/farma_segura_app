import 'dart:math';
import 'package:farma_segura_app/screen_add_profile/main.dart';
import 'package:flutter/material.dart';

class AddProfileAvatar extends StatelessWidget {
  final double bottomMargin;
  final double topMargin;

  AddProfileAvatar({this.bottomMargin, this.topMargin});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final mediaQuery = MediaQuery.of(context);
        final maxHeight =
            min(mediaQuery.size.height * .2, constraints.maxHeight);
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ScreenAddSubProfile.routeName);
          },
          child: Container(
            margin: EdgeInsets.only(
              bottom: bottomMargin ?? maxHeight * .25,
              top: topMargin ?? 0,
            ),
            padding: EdgeInsets.all(10),
            child: Icon(Icons.add, color: Colors.black87),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.75),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    blurRadius: 2,
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    offset: Offset(2, 2)),
              ],
            ),
          ),
        );
      },
    );
  }
}
