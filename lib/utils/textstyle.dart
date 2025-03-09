import 'package:flutter/material.dart';

TextStyle kTextStyle(
  double size, {
  bool? isBold = false,
  Color color = Colors.black,
}) {
  return TextStyle(
    fontSize: size,
    fontWeight: isBold! ? FontWeight.w700 : FontWeight.normal,
    color: color,
    fontFamily: "Montserrat",
  );
}
