import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

////Color utilities
final materialThemeData = ThemeData(
    scaffoldBackgroundColor: AppColor.background,
    colorScheme: const ColorScheme.dark().copyWith(
        primary: AppColor.primary,
        secondary: AppColor.secondary,
        error: AppColor.error),
    buttonTheme: ButtonThemeData(
        buttonColor: AppColor.primary, textTheme: ButtonTextTheme.primary),
    appBarTheme:
        AppBarTheme(color: AppColor.primary, foregroundColor: AppColor.text)
    /*
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: Colors.black54, fontSize: 16.0),
  ),
   */
    );

final cupertinoTheme =
    MaterialBasedCupertinoThemeData(materialTheme: materialThemeData).copyWith(
  barBackgroundColor: AppColor.primary,
  primaryColor: AppColor.text,
  textTheme: CupertinoTextThemeData(
    primaryColor: AppColor.text,
    navTitleTextStyle: TextStyle(
        color: AppColor.text,
        fontWeight: FontWeight.w600,
        fontSize: 18.0,
        inherit: false),
  ),
);

class AppColor {
  static Color primary = const Color(0xFF00798C);
  static Color secondary = const Color(0xFFEDAE49);
  static Color third = const Color(0xFFD1495B);
  static Color fourth = const Color(0xFF30638E);
  static Color fiveth = const Color(0xFF003D5B);

  static Color error = const Color(0xFFB43434);
  static Color valid = const Color(0xFF04724D);

  static Color background = const Color(0xFF1A1E24);
  static Color backgroundLight1 = const Color(0xFF262A31);
  static Color backgroundLight2 = const Color(0xFF2C2D39);
  static Color backgroundDark1 = const Color(0xFF111318);

  static Color text = const Color(0xFFE7E7E7);
  static Color textLigth1 = const Color(0xFFEFEFEF);
  static Color textLigth2 = const Color(0xFFFFFFFF);
  static Color textDark1 = const Color(0xFFD0D0D0);
  static Color textDark2 = const Color(0xFFBFBFBF);
  static Color textDark3 = const Color(0xFFAAA9A9);
}
