import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

////Color utilities
final materialThemeData = ThemeData(

    scaffoldBackgroundColor: const Color(0xFFF3F3F3),
    colorScheme: const ColorScheme.light().copyWith(
      primary: Colors.deepOrange,
      secondary: Colors.indigo,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.deepOrange,
    ),
    textTheme: const TextTheme(
      button: TextStyle(color: Colors.white, fontSize: 16.0),
      bodyText1: TextStyle(color: Colors.black54, fontSize: 16.0)
    ));

final cupertinoTheme = MaterialBasedCupertinoThemeData(materialTheme: materialThemeData);

const cupertinoTheme2 = CupertinoThemeData(
    primaryColor: Colors.redAccent,
    barBackgroundColor: Colors.deepOrange,
    primaryContrastingColor: Colors.redAccent,
    scaffoldBackgroundColor: Color(0xFFF3F3F3),
    textTheme: CupertinoTextThemeData(
      primaryColor: Colors.white,
      //navTitleTextStyle: TextStyle(color: Colors.white, fontSize: 18.0)
    ));

const toolbarTextStyle = TextStyle(color: Colors.white, fontSize: 16.0);
const textStyleBlackPlain = TextStyle(color: Colors.black, fontSize: 30);
final bottomTabsBackground = Colors.blueGrey;
const bottomNavTextStyle = TextStyle(color: Colors.white, fontSize: 14.0);
const toolbarButtonTextStyle = TextStyle(color: Colors.white, fontSize: 14.0);
const tabsContentText = TextStyle(color: Colors.brown, fontSize: 30);
