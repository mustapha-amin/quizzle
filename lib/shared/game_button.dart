import 'package:flutter/material.dart';
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

class _GameButtonState extends State<GameButton>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Size?> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reverse();
        }
      });

    _sizeAnimation = SizeTween(
      begin: Size(widget.width, widget.height),
      end: Size(widget.width + 30, widget.height + 10),
    ).animate(animationController);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        animationController.forward();
        await Future.delayed(
            const Duration(milliseconds: 800), () => widget.callback);
      },
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, _) {
          return Container(
            width: _sizeAnimation.value!.width,
            height: _sizeAnimation.value!.height,
            decoration: BoxDecoration(
              color: widget.buttonColor,
            ),
            child: Text(
              widget.label,
              style: kTextStyle(widget.labelFontSize, color: widget.labelColor),
            ),
          );
        },
      ),
    );
  }
}