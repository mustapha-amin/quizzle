import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quizzle/core/enums.dart';
import 'package:quizzle/features/quiz/controllers/quiz_fetcher.dart';
import 'package:quizzle/utils/extensions.dart';
import 'package:quizzle/utils/textstyle.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/quiz_category_widget.dart';
import 'quiz_screen.dart';
import 'package:quizzle/utils/dialog.dart';

class QuizCategories extends ConsumerStatefulWidget {
  const QuizCategories({super.key});

  @override
  ConsumerState<QuizCategories> createState() => _QuizCategoriesState();
}

class _QuizCategoriesState extends ConsumerState<QuizCategories> {
  @override
  Widget build(BuildContext context) {
    ref.listen(quizQuistionsCtrlProvider, (_, next) {
      if (next.quizzes!.isNotEmpty) {
        context.push(const QuizScreen());
      }
      if (next.error!.isNotEmpty) {
        showCustomDialog(
          context: context,
          title: "Error",
          message: next.error!,
        );
      }
    });
    return Scaffold(
      body: AbsorbPointer(
        absorbing: ref.watch(quizQuistionsCtrlProvider).isLoading!,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  centerTitle: true,
                  title: Text(
                    "Quiz categories",
                    style: kTextStyle(20, color: Colors.black),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      ...QuizCategory.values.map((category) {
                        return QuizCategoryWidget(
                          category: category,
                          callback: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                int selectedIndex = 0;
                                return StatefulBuilder(
                                    builder: (context, setState) {
                                  return SimpleDialog(
                                    contentPadding: const EdgeInsets.fromLTRB(
                                      10,
                                      5,
                                      10,
                                      10,
                                    ),
                                    title: Text(
                                      "Select difficulty",
                                      style: kTextStyle(
                                        20,
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
                                                    15,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                IconButton(
                                                  iconSize: 30,
                                                  onPressed: () {
                                                    setState(() {
                                                      selectedIndex = index;
                                                    });
                                                  },
                                                  icon: Icon(Icons.star,
                                                      color:
                                                          selectedIndex >= index
                                                              ? Colors.amber
                                                              : Colors.grey),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          SizedBox(
                                            width: 35.w,
                                            child: TextButton(
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors.red,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
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
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.blue[800],
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                ref
                                                    .read(
                                                        quizQuistionsCtrlProvider
                                                            .notifier)
                                                    .fetchQuestions(
                                                        category,
                                                        switch (selectedIndex) {
                                                          0 =>
                                                            QuizDifficulty.easy,
                                                          1 => QuizDifficulty
                                                              .medium,
                                                          _ =>
                                                            QuizDifficulty.hard,
                                                        });
                                              },
                                              child: Text(
                                                "Start",
                                                style: kTextStyle(
                                                  14,
                                                  color: Colors.white,
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
                            );
                          },
                        );
                      })
                    ],
                  ),
                )
              ],
            ),
            Center(
              child: switch (ref.watch(quizQuistionsCtrlProvider).isLoading) {
                true => SpinKitChasingDots(
                    size: 80,
                    color: Theme.of(context).primaryColor,
                    duration: const Duration(milliseconds: 800),
                  ),
                _ => const SizedBox()
              },
            )
          ],
        ),
      ),
    );
  }
}
