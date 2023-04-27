import 'package:flutter/material.dart';

class AppTheme {
  static const colorPrimary = Color(0xFFc09417);
  static const colorPrimaryDark = Color(0xFF3c3c3c);
  static const colorAccent = Color(0xFF020202);
  static const colorDrawerColor = Color(0x96424E5C);
  static const colorDrawerSelected = Color(0xff424E5C);
  static const colorPrimaryTrans = Color(0x6A134A92);
  static const toolbarHeader = Color(0xfff4f4f4);
  static const bottomNavColor = Color(0xffF7F7F7);
  static const cardColorWhite = Color(0xafffffff);
  static const colorStepper = Color(0xff8c6e49);
  static const colorSeekBarBackground = Color(0xffababab);
  static const colorSeekProgress = Color(0xff0169AF);
  static const colorSeekSecondary = Color(0xffac162c);
  static const colorWhite = Color(0xffffffff);
  static const colorGrey = Color(0xff9E9E9E);

  static LinearGradient loginGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      const Color(0xff032849),
      const Color(0xff032747).withOpacity(.96),
      const Color(0xff01080F).withOpacity(0),
    ],
  );

  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'pdfInTextUniversal',
    appBarTheme:  const AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      color: Colors.white,

    ),
    scaffoldBackgroundColor: Colors.white,
    primaryColor: colorPrimary,
    colorScheme: const ColorScheme.light(
      primary: colorPrimary,
      secondary: colorAccent,
    ),
    dividerColor: Colors.grey,
  );

  static TextStyle boldStyle({required Color color, double? size}) {
    return TextStyle(
        color: color,
        fontSize: size ?? 25,
        fontWeight: FontWeight.bold);
  }

  static TextStyle lightStyle({required Color color, double? size}) {
    return TextStyle(

        color: color,
        fontSize: size ?? 15,
        fontWeight: FontWeight.w500);
  }
}
