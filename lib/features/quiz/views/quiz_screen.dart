import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzle/features/quiz/controllers/quiz_fetcher.dart';
import 'package:quizzle/features/quiz/controllers/quiz_progress_ctrl.dart';
import 'package:quizzle/features/quiz/widgets/options.dart';
import 'package:quizzle/shared/game_button.dart';
import 'package:quizzle/utils/dialog.dart';
import 'package:quizzle/utils/extensions.dart';
import 'package:quizzle/utils/textstyle.dart';
import 'package:sizer/sizer.dart';

import 'quiz_results.dart';

class QuizScreen extends ConsumerStatefulWidget {
  const QuizScreen({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  String? selectedOption;
  bool? canPop = false;

  @override
  Widget build(BuildContext context) {
    final quizProgress = ref.watch(quizProgressNotifierProvider);
    final quizzesProvider = ref.watch(quizQuistionsCtrlProvider);
    final currentQuestionIndex = quizProgress.index + 1;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  "Quit game",
                  style: kTextStyle(18, color: Colors.black),
                ),
                content: Text(
                  "Do you want to quit your current game",
                  style: kTextStyle(
                    12,
                    color: Colors.black,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("No"),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pop(context);
                    },
                    child: const Text("Yes"),
                  ),
                ],
              );
            },
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "$currentQuestionIndex / 20",
            style: kTextStyle(20, color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 8,
                child: TweenAnimationBuilder(
                  tween: Tween<double>(
                      begin: 0, end: currentQuestionIndex.toDouble()),
                  duration: const Duration(milliseconds: 500),
                  builder: (context, value, _) {
                    return LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(6),
                      value: value / 20,
                      color: Theme.of(context).primaryColor,
                      backgroundColor: Colors.grey,
                    ).padX(5);
                  },
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Column(
                children: [
                  Text(
                    quizzesProvider.quizzes![quizProgress.index].question,
                    style: kTextStyle(
                      23,
                      color: Colors.black,
                      isBold: true,
                    ),
                  ).padX(8),
                  ...quizzesProvider.quizzes![quizProgress.index].options.map(
                    (option) {
                      return OptionWidget(
                        option: option,
                        color: ref
                                .watch(quizProgressNotifierProvider.notifier)
                                .answerIsSelected(option, quizProgress.index)
                            ? Colors.amber[600]!
                            : Colors.white,
                        onPressed: () {
                          ref
                              .read(quizProgressNotifierProvider.notifier)
                              .answerQuestion(quizProgress.index, option);
                        },
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GameButton(
                        label: "Previous",
                        callback: () {
                          ref
                              .read(quizProgressNotifierProvider.notifier)
                              .prev();
                        },
                        height: 7.h,
                        width: 38.w,
                        buttonColor: currentQuestionIndex == 1
                            ? Colors.grey
                            : Theme.of(context).primaryColor,
                        labelColor: Colors.white,
                        labelFontSize: 20,
                      ),
                      GameButton(
                        label: currentQuestionIndex == 20 ? "Complete" : "Next",
                        callback: () {
                          log(quizProgress.selectedAnswers.toString());
                          if (ref
                              .read(quizProgressNotifierProvider.notifier)
                              .answerSlotNotEmpty(quizProgress.index)) {
                            if (currentQuestionIndex != 20) {
                              ref
                                  .read(quizProgressNotifierProvider.notifier)
                                  .next();
                            } else {
                              ref
                                  .read(quizProgressNotifierProvider.notifier)
                                  .computeScore();
                              context.push(const QuizResults());
                            }
                          }
                        },
                        height: 7.h,
                        width: 38.w,
                        buttonColor: ref
                                .read(quizProgressNotifierProvider.notifier)
                                .answerSlotNotEmpty(quizProgress.index)
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                        labelColor: Colors.white,
                        labelFontSize: 20,
                      ),
                    ],
                  ).padAll(8)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
