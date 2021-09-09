import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
        left: 20,
        right: 15,
        bottom: 15,
      ),
      child: Text(
        'FS.',
        style: TextStyle(
          fontFamily: 'Nunito',
          fontSize: 36,
        ),
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // borderRadius: BorderRadius.circular(40),
        color: Colors.white,
        // boxShadow: [
        //   BoxShadow(
        //       blurRadius: 2,
        //       color: Colors.black.withOpacity(0.3),
        //       spreadRadius: 2,
        //       offset: Offset(2, 2)),
        // ],
      ),
    );
  }
}
