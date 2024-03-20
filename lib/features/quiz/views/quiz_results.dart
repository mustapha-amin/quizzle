import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzle/core/enums.dart';
import 'package:quizzle/features/quiz/controllers/quiz_fetcher.dart';
import 'package:quizzle/features/quiz/controllers/quiz_progress_ctrl.dart';
import 'package:quizzle/utils/extensions.dart';
import 'package:quizzle/utils/textstyle.dart';
import 'package:sizer/sizer.dart';

class QuizResults extends ConsumerStatefulWidget {
  const QuizResults({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuizResultsState();
}

class _QuizResultsState extends ConsumerState<QuizResults> {
  String expansionTileTitle = "Show Results";
  @override
  Widget build(BuildContext context) {
    final quizProgressCtrl = ref.watch(quizProgressNotifierProvider);
    final quizQuestionsCtrl = ref.watch(quizQuistionsCtrlProvider);
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 35.w,
                  width: 35.w,
                  child: TweenAnimationBuilder(
                    curve: Curves.easeInOutCubic,
                    tween: Tween<double>(
                      begin: 0,
                      end: quizProgressCtrl.scoreAndRemark!.$1 / 20,
                    ),
                    duration: const Duration(milliseconds: 1500),
                    builder: (context, value, _) {
                      return CircularProgressIndicator(
                        value: value,
                        backgroundColor: Colors.grey[400],
                        strokeWidth: 8,
                      );
                    },
                  ),
                ).padY(6),
                Text.rich(
                  TextSpan(
                    text: '${quizProgressCtrl.scoreAndRemark!.$1}',
                    style: kTextStyle(
                      25,
                      color: switch (quizProgressCtrl.scoreAndRemark!.$2) {
                        QuizRemark.poor => Colors.red,
                        QuizRemark.fair => Colors.amber,
                        QuizRemark.good => Colors.amber[700],
                        QuizRemark.veryGood => Colors.green[400],
                        QuizRemark.excellent => Colors.green[800],
                      },
                      isBold: true,
                    ),
                    children: [
                      TextSpan(
                        text: ' / ',
                        style: kTextStyle(
                          30,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: '20 ',
                        style: kTextStyle(
                          30,
                          color: Colors.green[800],
                          isBold: true,
                        ),
                      )
                    ],
                  ),
                ).centralize(),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              quizProgressCtrl.scoreAndRemark!.$2.message,
              style: kTextStyle(
                30,
                isBold: true,
                color: switch (quizProgressCtrl.scoreAndRemark!.$2) {
                  QuizRemark.poor => Colors.red,
                  QuizRemark.fair => Colors.amber,
                  QuizRemark.good => Colors.amber[700],
                  QuizRemark.veryGood => Colors.green[400],
                  QuizRemark.excellent => Colors.green[800],
                },
              ),
            ).centralize(),
            Card(
              child: ExpansionTile(
                title: Text(
                  expansionTileTitle,
                  style: kTextStyle(15, color: Colors.green),
                ),
                onExpansionChanged: (isExpanded) {
                  setState(() {
                    expansionTileTitle =
                        isExpanded ? "Hide Results" : "Show Results";
                  });
                },
                children: [
                  ...quizQuestionsCtrl.quizzes!.map(
                    (quiz) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${quizQuestionsCtrl.quizzes!.indexOf(quiz) + 1}. ${quiz.question}",
                          style: kTextStyle(15, color: Colors.black),
                        ),
                        Row(
                          children: [
                            Text(
                              "Selected: ",
                              style: kTextStyle(12, color: Colors.black),
                            ),
                            Text(
                              quizProgressCtrl.selectedAnswers[
                                  quizQuestionsCtrl.quizzes!.indexOf(quiz)]!,
                              style: kTextStyle(12, color: Colors.black),
                            ),
                            switch (quizProgressCtrl.selectedAnswers[
                                    quizQuestionsCtrl.quizzes!
                                        .indexOf(quiz)]! ==
                                quiz.answer) {
                              true => const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                              _ => const Icon(
                                  Icons.cancel_sharp,
                                  color: Colors.red,
                                )
                            }
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Answer: ",
                              style: kTextStyle(12, color: Colors.black),
                            ),
                            Text(
                              quiz.answer,
                              style: kTextStyle(12, color: Colors.black),
                            ),
                            const Icon(
                              Icons.check,
                              color: Colors.green,
                            )
                          ],
                        ),
                        if (quizQuestionsCtrl.quizzes!.indexOf(quiz) < 19)
                          const SizedBox(
                            height: 30,
                          )
                      ],
                    ).padX(8),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
