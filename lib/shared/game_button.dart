import 'package:flutter/material.dart';
import 'package:quizzle/utils/extensions.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sizer/sizer.dart';
import '../utils/textstyle.dart';

class GameButton extends StatefulWidget {
  final String label;
  final VoidCallback callback;
  final double labelFontSize;
  final Color buttonColor, labelColor;
  const GameButton({
    required this.label,
    required this.callback,
    required this.buttonColor,
    required this.labelColor,
    required this.labelFontSize,
    super.key,
  });

  @override
  State<GameButton> createState() => _GameButtonState();
}

class _GameButtonState extends State<GameButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28.w,
      child: ShadButton(
        child: Text(
          widget.label,
          style: kTextStyle(widget.labelFontSize, color: widget.labelColor),
        ),
        onPressed: widget.callback,
        backgroundColor: widget.buttonColor,
      ),
    );
  }
}
