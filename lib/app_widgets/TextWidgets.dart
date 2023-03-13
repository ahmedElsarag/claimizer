import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget normalText(String txt,
    {Color color = Colors.black,
    double fontSize = 14,
    TextAlign textAlign,
    TextDecoration decoration,
    String fontFamily}) {
  return Text(txt,
      textAlign: textAlign,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w100,
          decoration: decoration,
          fontFamily: fontFamily));
}

Widget mediumText(String txt,
    {Color color = Colors.black,
    double fontSize = 14,
    TextAlign textAlign,
    TextDecoration decoration,
    String fontFamily}) {
  return Text(txt,
      textAlign: textAlign,
      style: TextStyle(
          fontFamily: fontFamily,
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w500));
}

Widget boldText(String txt,
    {Color color = Colors.black,
    double fontSize = 14,
    TextAlign textAlign,
    TextDecoration decoration,
    String fontFamily,
    FontWeight fontWeight = FontWeight.w900}) {
  return Text(txt,
      textAlign: textAlign,
      style: TextStyle(
          fontFamily: fontFamily,
          decoration: decoration,
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight));
}
