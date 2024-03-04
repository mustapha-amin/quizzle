import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

TextStyle kTextStyle(
  double size, {
  FontWeight? fontWeight,
  Color? color,
}) {
  return GoogleFonts.poppins(
    fontSize: size.sp,
    fontWeight: fontWeight ?? FontWeight.normal,
    color: color ?? Colors.white,
  );
}
