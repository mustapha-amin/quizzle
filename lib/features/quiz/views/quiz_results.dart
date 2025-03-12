import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:quizzle/core/enums.dart';
import 'package:quizzle/features/quiz/controllers/quiz_fetcher.dart';
import 'package:quizzle/features/quiz/controllers/quiz_progress_ctrl.dart';
import 'package:quizzle/utils/extensions.dart';
import 'package:quizzle/utils/textstyle.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sizer/sizer.dart';

class QuizResults extends ConsumerStatefulWidget {
  const QuizResults({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuizResultsState();
}

class _QuizResultsState extends ConsumerState<QuizResults> {
  String expansionTileTitle = "Show Results";
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final quizProgressCtrl = ref.watch(quizProgressNotifierProvider);
    final quizQuestionsCtrl = ref.watch(quizQuistionsCtrlProvider);
    return Scaffold(
      body: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 32),
          Expanded(
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
                    Column(
                      children: [
                        Text.rich(
                          TextSpan(
                            text: '${quizProgressCtrl.scoreAndRemark!.$1}',
                            style: kTextStyle(
                              25,
                              color: switch (
                                  quizProgressCtrl.scoreAndRemark!.$2) {
                                QuizRemark.poor => Colors.red,
                                QuizRemark.fair => Colors.amber,
                                QuizRemark.good => Colors.amber[700],
                                QuizRemark.veryGood => Colors.green[400],
                                QuizRemark.excellent => Colors.green[800],
                              }!,
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
                                  color: Colors.green[800]!,
                                  isBold: true,
                                ),
                              ),
                            ],
                          ),
                        ).centralize(),
                        Text(
                          quizProgressCtrl.scoreAndRemark!.$2.message,
                          style: kTextStyle(
                            20,
                            isBold: true,
                            color: switch (
                                quizProgressCtrl.scoreAndRemark!.$2) {
                              QuizRemark.poor => Colors.red,
                              QuizRemark.fair => Colors.amber,
                              QuizRemark.good => Colors.amber[700],
                              QuizRemark.veryGood => Colors.green[400],
                              QuizRemark.excellent => Colors.green[800],
                            }!,
                          ),
                        ).centralize(),
                      ],
                    ),
                  ],
                ),
                ShadButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: Text(
                    "Return home",
                    style: kTextStyle(15, color: Colors.white),
                  ),
                ).centralize(),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Results",
                  style: kTextStyle(18, isBold: true),
                ).centralize(),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${quizQuestionsCtrl.quizzes![currentIndex].question}",
                      style: kTextStyle(15, color: Colors.black),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: quizProgressCtrl.selectedAnswers[currentIndex] ==
                                quizQuestionsCtrl.quizzes![currentIndex].answer
                            ? const Color.fromARGB(255, 191, 255, 240)
                            : const Color(0xfffceaea),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            width: 1.5,
                            color: quizProgressCtrl
                                        .selectedAnswers[currentIndex] ==
                                    quizQuestionsCtrl
                                        .quizzes![currentIndex].answer
                                ? Colors.green
                                : Colors.red),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Selected: ${quizProgressCtrl.selectedAnswers[currentIndex]!}",
                            style: kTextStyle(14,
                                color: quizProgressCtrl
                                            .selectedAnswers[currentIndex] ==
                                        quizQuestionsCtrl
                                            .quizzes![currentIndex].answer
                                    ? Colors.green
                                    : Colors.red,
                                isBold: true),
                          ),
                          switch (quizProgressCtrl
                                  .selectedAnswers[currentIndex] ==
                              quizQuestionsCtrl.quizzes![currentIndex].answer) {
                            true => const Icon(
                                Iconsax.tick_circle,
                                color: Colors.green,
                                size: 20,
                              ),
                            _ => const Icon(
                                Icons.cancel_sharp,
                                color: Colors.red,
                              )
                          }
                        ],
                      ).padX(12).padY(16),
                    ),
                    if (quizProgressCtrl.selectedAnswers[currentIndex] !=
                        quizQuestionsCtrl.quizzes![currentIndex].answer)
                      Container(
                        decoration: BoxDecoration(
                          color:
                              quizProgressCtrl.selectedAnswers[currentIndex] !=
                                      quizQuestionsCtrl
                                          .quizzes![currentIndex].answer
                                  ? const Color.fromARGB(255, 191, 255, 240)
                                  : const Color(0xfffceaea),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              width: 1.5,
                              color: quizProgressCtrl
                                          .selectedAnswers[currentIndex] !=
                                      quizQuestionsCtrl
                                          .quizzes![currentIndex].answer
                                  ? Colors.green
                                  : Colors.red),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Answer: ${quizQuestionsCtrl.quizzes![currentIndex].answer}",
                              style: kTextStyle(14,
                                  color: Colors.green, isBold: true),
                            ),
                            const Icon(
                              Iconsax.tick_circle,
                              color: Colors.green,
                            )
                          ],
                        ).padX(12).padY(16),
                      ),
                  ],
                ).padX(8),
              ],
            ).padX(10),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
              ),
              itemCount: 20,
              itemBuilder: (context, index) {
                return Container(
                  decoration: ShapeDecoration(
                    color: currentIndex == index
                        ? switch (quizProgressCtrl.selectedAnswers[index] ==
                            quizQuestionsCtrl.quizzes![index].answer) {
                            true => Colors.green,
                            _ => Colors.red
                          }
                        : null,
                    shape: SmoothRectangleBorder(
                      side: BorderSide(
                        color: switch (
                            quizProgressCtrl.selectedAnswers[index] ==
                                quizQuestionsCtrl.quizzes![index].answer) {
                          true => Colors.green,
                          _ => Colors.red,
                        },
                        width: 2,
                      ),
                      borderRadius: SmoothBorderRadius(
                        cornerRadius: 8,
                        cornerSmoothing: 0.4,
                      ),
                    ),
                  ),
                  child: InkWell(
                    customBorder: SmoothRectangleBorder(
                      borderRadius: SmoothBorderRadius(
                        cornerRadius: 8,
                        cornerSmoothing: 0.4,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    child: Text(
                      '${index + 1}',
                      style: kTextStyle(
                        16,
                        isBold: true,
                        color: currentIndex != index
                            ? switch (quizProgressCtrl.selectedAnswers[index] ==
                                quizQuestionsCtrl.quizzes![index].answer) {
                                true => Colors.green,
                                _ => Colors.red
                              }
                            : Colors.white,
                      ),
                    ).centralize(),
                  ),
                ).padX(10).padY(10);
              },
            ).padX(5),
          )
        ],
      ),
    );
  }
}
