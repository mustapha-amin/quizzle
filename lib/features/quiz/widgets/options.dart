import 'package:flutter/material.dart';
import 'package:quizzle/utils/extensions.dart';
import 'package:quizzle/utils/textstyle.dart';
import 'package:sizer/sizer.dart';

class OptionWidget extends StatelessWidget {
  final String option;
  final Color color;
  final VoidCallback onPressed;
  const OptionWidget({
    required this.option,
    required this.color,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[900]!,
                spreadRadius: 0.8,
              )
            ]),
        width: 100.w,
        height: 8.h,
        child: Center(
          child: Text(
            option,
            style: kTextStyle(
              15,
              color: Colors.black,
            ),
          ),
        ),
      ),
    ).padAll(8);
  }
}
