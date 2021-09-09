import 'dart:io';
import 'package:farma_segura_app/widgets/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveApp extends StatelessWidget {
  final Widget homePage;
  Map<String, WidgetBuilder> routes;

  AdaptiveApp({
    @required this.homePage,
    this.routes,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoApp(
            routes: routes ?? {},
            localizationsDelegates: [
              DefaultMaterialLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
              DefaultWidgetsLocalizations.delegate,
            ],
            title: TITLE,
            theme: CupertinoThemeData(
              primaryContrastingColor: Colors.blue,
              primaryColor: Colors.blue,
              barBackgroundColor: Colors.lightBlue,
              textTheme: CupertinoTextThemeData(
                textStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20,
                  color: Colors.black87,
                ),
                primaryColor: Colors.black54,
                navTitleTextStyle: TextStyle(
                  // color: Colors.white,
                  fontFamily: 'Montserrat',
                  // fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            home: homePage,
          )
        : MaterialApp(
            routes: routes ?? {},
            title: 'Personal Expenses',
            theme: ThemeData(
              // accentColor: Colors.green,
              // primarySwatch: Colors.green,
              fontFamily: 'Quicksand',
              textTheme: ThemeData.light().textTheme.copyWith(
                    headline6: TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
              appBarTheme: AppBarTheme(
                textTheme: ThemeData.light().textTheme.copyWith(
                      headline6: TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
              ),
            ),
            home: homePage,
          );
  }
}
