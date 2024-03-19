import 'package:flutter/material.dart';
import 'package:quizzle/core/enums.dart';
import 'package:quizzle/utils/extensions.dart';
import 'package:quizzle/utils/textstyle.dart';
import 'package:sizer/sizer.dart';

import '../../../core/image_paths.dart';

class QuizCategoryWidget extends StatelessWidget {
  final QuizCategory category;
  final VoidCallback callback;
  const QuizCategoryWidget({
    required this.category,
    required this.callback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      elevation: 4,
      shadowColor: Colors.grey[200],
      child: SizedBox(
        height: 28.h,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.asset(
                ImagePaths.quizCategoryGen(category.name),
                fit: BoxFit.cover,
                repeat: ImageRepeat.repeatX,
                width: 100.w,
                height: 18.h,
                filterQuality: FilterQuality.high,
                errorBuilder: (context, _, __) {
                  return SizedBox(
                    width: 20.w,
                  );
                },
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.name.capitalizeFirst,
                  style: kTextStyle(20, color: Colors.black, isBold: true),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  onPressed: callback,
                  child: Text(
                    "Play now",
                    style: kTextStyle(15),
                  ),
                )
              ],
            ).padX(20),
          ],
        ),
      ),
    ).padX(10).padY(4);
  }
}
