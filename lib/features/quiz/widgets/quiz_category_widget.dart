import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:quizzle/core/enums.dart';
import 'package:quizzle/utils/extensions.dart';
import 'package:quizzle/utils/textstyle.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
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
    return ShadCard(
      radius: BorderRadius.circular(20),
      padding: EdgeInsets.all(0),
      //elevation: 3,
      // shadowColor: Colors.grey[200],
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  category.name.capitalizeFirst,
                  style: kTextStyle(20, color: Colors.black, isBold: true),
                ),
                ShadIconButton(
                  icon: Icon(
                    Iconsax.game_copy,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: callback,
                )
              ],
            ).padX(20),
          ],
        ),
      ),
    ).padX(10).padY(4);
  }
}
