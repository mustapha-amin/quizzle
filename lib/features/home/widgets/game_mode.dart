import 'package:flutter/material.dart';
import 'package:quizzle/utils/textstyle.dart';
import 'package:sizer/sizer.dart';

class GameMode extends StatelessWidget {
  String img, label;
  Widget destination;
  GameMode({required this.img, required this.label, required this.destination, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => destination),
            );
          },
          child: Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(img),
              ),
            ),
          ),
        ),
        Text(
          label,
          style: kTextStyle(20, color: Colors.black, isBold: true),
        ),
      ],
    );
  }
}
