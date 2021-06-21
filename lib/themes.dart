import 'package:flutter/material.dart';
import 'package:survey/gen/fonts.gen.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: Colors.white,
  accentColor: Colors.white24,
  fontFamily: FontFamily.neuzeit,
  textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.white),
  textTheme: TextTheme(
    headline4: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
    headline5: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
    subtitle1: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
    bodyText1: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
      padding: MaterialStateProperty.all(EdgeInsets.only(top: 20, bottom: 14)),
      backgroundColor: MaterialStateProperty.all(Colors.white),
      foregroundColor: MaterialStateProperty.all(Colors.black),
      overlayColor: MaterialStateProperty.all(Colors.black12),
      textStyle: MaterialStateProperty.all(
        TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w900,
        ),
      ),
    ),
  ),
);
