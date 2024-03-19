import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

TextStyle kTextStyle(
  double size, {
  bool? isBold = false,
  Color? color,
}) {
  return TextStyle(
    fontSize: size.sp,
    fontWeight: isBold! ? FontWeight.w700 : FontWeight.normal,
    color: color ?? Colors.white,
    fontFamily: "Montserrat",
  );
}