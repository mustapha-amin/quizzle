import 'package:flutter/material.dart';
import 'package:quizzle/utils/extensions.dart';
import '../utils/textstyle.dart';

class GameButton extends StatefulWidget {
  final String label;
  final VoidCallback callback;
  final double width, height, labelFontSize;
  final Color buttonColor, labelColor;
  const GameButton({
    required this.label,
    required this.callback,
    required this.height,
    required this.width,
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
    return InkWell(
      onTap: () {
        widget.callback.call();
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.buttonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          widget.label,
          style: kTextStyle(widget.labelFontSize, color: widget.labelColor),
        ).centralize(),
      ),
    );
  }
}
