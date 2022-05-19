import 'constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

ThemeData theme() {
  return ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: appBarTheme(),
    scrollbarTheme: const ScrollbarThemeData(),
    fontFamily: "Poppins",
    textTheme: textTheme(),
    inputDecorationTheme: inputDecoration(),
    primaryColor: primaryColor,
  );
}

InputDecorationTheme inputDecoration() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30.0),
    borderSide: const BorderSide(color: Colors.transparent),
    gapPadding: 10,
  );

  OutlineInputBorder focusedOutlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(color: primaryColor),
      gapPadding: 10);

  return InputDecorationTheme(
      contentPadding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
      enabledBorder: outlineInputBorder,
      focusedBorder: focusedOutlineInputBorder,
      border: outlineInputBorder,
      fillColor: lightPrimaryColor,
      filled: true,
      hintStyle: const TextStyle(fontWeight: FontWeight.bold));
}

TextTheme textTheme() {
  return const TextTheme(
    headline2: TextStyle(
      color: textGray,
      fontSize: 15,
      fontFamily: "Poppins",
      fontWeight: FontWeight.normal,
    ),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true);
}

TextStyle textStyleNormal(Color color, {double? fontsize}) {
  return TextStyle(
    color: color,
    fontSize: fontsize ?? 14,
    fontFamily: "Poppins",
    fontWeight: FontWeight.normal,
  );
}

TextStyle textStyleMedium() {
  return const TextStyle(
    color: textGray,
    fontSize: 14,
    fontFamily: "Poppins",
    fontWeight: FontWeight.w500,
  );
}

TextStyle textStyleHintView() {
  return const TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontFamily: "Poppins",
    fontWeight: FontWeight.w500,
  );
}

TextStyle textStyleHeaderBold() {
  return const TextStyle(
    color: primaryColor,
    fontSize: 26,
    fontFamily: "Poppins",
    fontWeight: FontWeight.bold,
  );
}

TextStyle textStyleBold(Color color, double fontsize) {
  return TextStyle(
    color: color,
    fontSize: fontsize,
    fontFamily: "Poppins",
    fontWeight: FontWeight.bold,
  );
}

BoxShadow shadowList() {
    return BoxShadow(
        color: Colors.black.withOpacity(0.2),
        spreadRadius: 0,
        blurRadius: 7,
        offset: const Offset(4, 4));
  }
