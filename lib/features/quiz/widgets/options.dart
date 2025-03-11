import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:quizzle/utils/extensions.dart';
import 'package:quizzle/utils/textstyle.dart';
import 'package:sizer/sizer.dart';

class OptionWidget extends StatelessWidget {
  final String option;
  final bool isSelected;
  final int index;
  final VoidCallback onPressed;
  const OptionWidget({
    required this.option,
    required this.isSelected,
    required this.onPressed,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(255, 191, 255, 240)
              : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: !isSelected ? null : Border.all(color: Colors.green),
          boxShadow: isSelected
              ? null
              : [
                  BoxShadow(
                    color: Colors.grey[200]!,
                    spreadRadius: 0.2,
                    blurRadius: 1,
                    offset: Offset(3, 3),
                  ),
                  BoxShadow(
                    color: Colors.grey[200]!,
                    spreadRadius: 0.2,
                    blurRadius: 1,
                    offset: Offset(-3, -3),
                  ),
                ],
        ),
        width: 100.w,
        height: 8.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 8,
          children: [
            Text(
              switch (index) {
                0 => "A",
                1 => "B",
                2 => "C",
                _ => "D",
              },
              style: kTextStyle(16, color: Colors.green[900]!, isBold: true),
            ),
            Center(
              child: SizedBox(
                width: 70.w,
                child: Text(
                  option,
                  style: kTextStyle(
                    15,
                    color: Colors.black,
                    isBold: true,
                  ),
                ),
              ),
            ),
            isSelected
                ? const Icon(
                    Iconsax.tick_circle,
                    color: Color.fromARGB(255, 102, 177, 159),
                    size: 23,
                  )
                : const SizedBox(width: 2),
          ],
        ).padX(15),
      ),
    ).padAll(8);
  }
}
