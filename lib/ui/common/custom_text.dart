import 'package:flutter/widgets.dart';

class AppFonts {
  static TextStyle regular({
    double fontSize = 16.0,
    Color? color,
    double height = 1.0,
    TextDecoration? decoration,
    FontStyle? fontStyle,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontWeight: fontWeight ?? FontWeight.w400,
      fontSize: fontSize,
      color: color,
      height: height,
      decoration: decoration,
      fontStyle: fontStyle,
    );
  }

  static TextStyle semiBold({
    double fontSize = 16.0,
    Color? color,
    double height = 1.0,
    TextDecoration? decoration,
    FontStyle? fontStyle,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontWeight: fontWeight ?? FontWeight.w600,
      fontSize: fontSize,
      color: color,
      height: height,
      decoration: decoration,
      fontStyle: fontStyle,
    );
  }

  static TextStyle extraBold({
    double fontSize = 16.0,
    Color? color,
    double height = 1.0,
    TextDecoration? decoration,
    FontStyle? fontStyle,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontWeight: fontWeight ?? FontWeight.w800,
      fontSize: fontSize,
      color: color,
      height: height,
      decoration: decoration,
      fontStyle: fontStyle,
    );
  }

  static TextStyle medium({
    double fontSize = 16.0,
    Color? color,
    double height = 1.0,
    TextDecoration? decoration,
    FontStyle? fontStyle,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontWeight: fontWeight ?? FontWeight.w500,
      fontSize: fontSize,
      color: color,
      height: height,
      decoration: decoration,
      fontStyle: fontStyle,
    );
  }

}
