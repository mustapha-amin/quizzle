import 'dart:developer';

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:quizzle/core/enums.dart';
import 'package:quizzle/features/quiz/controllers/quiz_fetcher.dart';
import 'package:quizzle/features/quiz/controllers/quiz_progress_ctrl.dart';
import 'package:quizzle/features/quiz/widgets/result_card.dart';
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
      appBar: AppBar(
        title: Text(
          "Results",
          style: kTextStyle(18, isBold: true),
        ),
        centerTitle: true,
      ),
      body: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ResultCard(
                  quizRemark: quizProgressCtrl.scoreAndRemark!.$2,
                  score: quizProgressCtrl.scoreAndRemark!.$1,
                ),
                FilledButton.icon(
                  onPressed: () {
                    Navigator.popUntil(
                        context, (predicate) => predicate.isFirst);
                  },
                  label: Text("Home"),
                  icon: Icon(Iconsax.home),
                ).padAll(8).centralize(),
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
