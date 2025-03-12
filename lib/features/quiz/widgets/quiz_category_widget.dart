import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:quizzle/core/enums.dart';
import 'package:quizzle/utils/extensions.dart';
import 'package:quizzle/utils/textstyle.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sizer/sizer.dart';
import 'package:figma_squircle/figma_squircle.dart';
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
    return InkWell(
      onTap: callback,
      customBorder: SmoothRectangleBorder(
        borderRadius: SmoothBorderRadius(
          cornerRadius: 24,
          cornerSmoothing: 0.6,
        ),
      ),
      child: ShadCard(
        radius: BorderRadius.circular(20),
        padding: const EdgeInsets.all(0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  decoration: ShapeDecoration(
                    shape: SmoothRectangleBorder(
                      borderRadius: SmoothBorderRadius(
                        cornerRadius: 10,
                        cornerSmoothing: 0.5,
                      ),
                    ),
                  ),
                  child: switch (category) {
                    QuizCategory.general => const Icon(
                        Iconsax.global_copy,
                        size: 30,
                      ),
                    QuizCategory.science => const Icon(
                        Iconsax.microscope_copy,
                        size: 30,
                      ),
                    QuizCategory.computing => const Icon(
                        Iconsax.monitor_copy,
                        size: 30,
                      ),
                    QuizCategory.technology => const Icon(
                        Iconsax.cpu_copy,
                        size: 30,
                      ),
                    QuizCategory.health => const Icon(
                        Iconsax.hospital_copy,
                        size: 30,
                      ),
                    QuizCategory.history => const Icon(
                        Iconsax.clock_copy,
                        size: 30,
                      ),
                    QuizCategory.gaming => const Icon(
                        Iconsax.game_copy,
                        size: 30,
                      ),
                    QuizCategory.movies => const Icon(
                        Iconsax.video_copy,
                        size: 30,
                      ),
                    QuizCategory.anime => const Icon(
                        Iconsax.video_play_copy,
                        size: 30,
                      ),
                    QuizCategory.books => const Icon(
                        Iconsax.book_1_copy,
                        size: 30,
                      ),
                    _ => const Icon(
                        Icons.sports_basketball_outlined,
                        size: 30,
                      ),
                  }),
              SizedBox(
                height: 2.h,
              ),
              Text(
                category.name.capitalizeFirst,
                style: kTextStyle(12, color: Colors.black, isBold: true),
              ).padX(20),
            ],
          ),
        ),
      ),
    );
  }
}
