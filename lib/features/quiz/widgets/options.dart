import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OptionWidget extends StatelessWidget {
  final String option;
  final bool isSelected;
  final VoidCallback onPressed;
  const OptionWidget({
    required this.option,
    required this.isSelected,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        color: isSelected ? Colors.amber : Colors.grey,
        width: 100.w,
        height: 20,
        child: Center(
          child: Text(option),
        ),
      ),
    );
  }
}
