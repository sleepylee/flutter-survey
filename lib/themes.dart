import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: Colors.white,
  accentColor: Colors.white24,
  fontFamily: 'Neuzeit',
  textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.white),
  textTheme: TextTheme(
      headline5: TextStyle(
          color: Colors.white,
          fontFamily: 'Neuzeit-Heavy',
          fontWeight: FontWeight.w900)),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0))),
          padding:
              MaterialStateProperty.all(EdgeInsets.only(top: 20, bottom: 14)),
          backgroundColor: MaterialStateProperty.all(Colors.white),
          foregroundColor: MaterialStateProperty.all(Colors.black),
          overlayColor: MaterialStateProperty.all(Colors.black12),
          textStyle: MaterialStateProperty.all(TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w900,
            fontFamily: 'Neuzeit',
          )))),
);
