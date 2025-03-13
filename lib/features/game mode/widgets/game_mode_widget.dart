import 'package:flutter/material.dart';
import 'package:quizzle/utils/extensions.dart';
import 'package:quizzle/utils/textstyle.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sizer/sizer.dart';

class GameModeWidget extends StatelessWidget {
  String label;
  VoidCallback onTap;
  IconData iconData;
  GameModeWidget({
    required this.iconData,
    required this.label,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: ShadCard(
        width: 50.w,
        height: 50.w,
        radius: BorderRadius.circular(24),
        child: Column(
          spacing: 12,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 56,
            ),
            Text(
              label,
              style: kTextStyle(20, color: Colors.black, isBold: true),
            ),
          ],
        ).centralize(),
      ),
    );
  }
}
