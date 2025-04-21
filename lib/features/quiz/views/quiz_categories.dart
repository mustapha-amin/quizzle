import 'dart:developer';

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:quizzle/core/enums.dart';
import 'package:quizzle/core/providers.dart';
import 'package:quizzle/features/auth/controllers/auth_controllers.dart';
import 'package:quizzle/features/game%20mode/views/game_mode.dart';
import 'package:quizzle/utils/extensions.dart';
import 'package:quizzle/utils/textstyle.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/quiz_category_widget.dart';

class QuizCategories extends ConsumerStatefulWidget {
  const QuizCategories({super.key});

  @override
  ConsumerState<QuizCategories> createState() => _QuizCategoriesState();
}

class _QuizCategoriesState extends ConsumerState<QuizCategories> {
  double initial = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 100,
            actions: [
              ref.watch(firebaseAuthProvider).currentUser!.isAnonymous
                  ? ShadButton(
                      onPressed: () {
                        ref
                            .read(authControllerNotifierProvider.notifier)
                            .signInGoogle(context, ref);
                      },
                      child: Text(
                        "Sign in",
                        style: kTextStyle(14, color: Colors.white),
                      ),
                      backgroundColor: Colors.grey[900],
                      decoration: ShadDecoration(
                          border: ShadBorder(
                        radius: BorderRadius.circular(24),
                      )),
                    ).padX(14)
                  : CircleAvatar(
                      backgroundImage: NetworkImage(ref
                          .watch(firebaseAuthProvider)
                          .currentUser!
                          .photoURL!),
                    ).padX(14),
            ],
            title: Text(
              "Hi, ${ref.watch(firebaseAuthProvider).currentUser!.isAnonymous ? "Guest" : ref.watch(firebaseAuthProvider).currentUser!.displayName}",
              style: kTextStyle(20, color: Colors.white, isBold: true),
            ),
            bottom: PreferredSize(
              preferredSize: Size(double.infinity, 150),
              child: Container(
                margin: EdgeInsets.all(15),
                width: double.infinity,
                decoration: ShapeDecoration(
                  color: Colors.grey[900],
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                      cornerRadius: 24,
                      cornerSmoothing: 0.6,
                    ),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      color: Colors.white,
                      width: 72,
                    ).padX(20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("🧠 Power Up!",
                              style: kTextStyle(28,
                                  color: Colors.white, isBold: true)),
                          Text(
                              "Dive into fun quizzes! Choose your category. 🚀",
                              style: kTextStyle(14, color: Colors.white)),
                        ],
                      ),
                    )
                  ],
                ).padY(32),
              ),
            ),
            flexibleSpace: Container(
              height: 250,
              decoration: ShapeDecoration.fromBoxDecoration(
                BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 9 / 12,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              delegate: SliverChildListDelegate([
                ...QuizCategory.values.map((category) {
                  return QuizCategoryWidget(
                    category: category,
                    callback: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(builder: (context, setState) {
                            return SimpleDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(
                                10,
                                8,
                                10,
                                10,
                              ),
                              titlePadding: EdgeInsets.all(15),
                              title: Text(
                                "Select difficulty",
                                style: kTextStyle(
                                  16,
                                  color: Colors.black,
                                  isBold: true,
                                ),
                              ).centralize(),
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ...List.generate(
                                      3,
                                      (index) => Column(
                                        children: [
                                          Text(
                                            switch (index) {
                                              0 => "Easy",
                                              1 => "Medium",
                                              _ => "Hard",
                                            },
                                            style: kTextStyle(
                                              14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                ShadSlider(
                                  divisions: 2,
                                  initialValue: initial,
                                  min: 0,
                                  max: 90,
                                  thumbColor: switch (initial) {
                                    0 => Colors.green,
                                    45 => Colors.amber,
                                    _ => Colors.red,
                                  },
                                  activeTrackColor: switch (initial) {
                                    0 => Colors.green,
                                    45 => Colors.amber,
                                    _ => Colors.red,
                                  },
                                  thumbBorderColor: switch (initial) {
                                    0 => Colors.green,
                                    45 => Colors.amber,
                                    _ => Colors.red,
                                  },
                                  onChangeEnd: (value) {
                                    log(value.toString());
                                    setState(() => initial = value);
                                  },
                                ).padY(10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      width: 35.w,
                                      child: ShadButton.ghost(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          initial = 0;
                                        },
                                        child: Text(
                                          "Cancel",
                                          style: kTextStyle(
                                            14,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 35.w,
                                      child: ShadButton(
                                        backgroundColor: Colors.blue,
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          context.push(GameMode(
                                            quizCategory: category,
                                            quizDifficulty: switch (initial) {
                                              0 => QuizDifficulty.easy,
                                              45 => QuizDifficulty.medium,
                                              _ => QuizDifficulty.hard,
                                            },
                                          ));
                                        },
                                        child: Text(
                                          "Next",
                                          style: kTextStyle(
                                            14,
                                            color: Colors.white,
                                            isBold: true,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            );
                          });
                        },
                      ).then((_) {
                        initial = 0;
                      });
                    },
                  );
                })
              ]),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          )
        ],
      ),
    );
  }
}
