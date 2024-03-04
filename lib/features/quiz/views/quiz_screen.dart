import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quizzle/core/enums.dart';
import 'package:quizzle/features/quiz/controllers/quiz_fetcher.dart';
import 'package:quizzle/features/quiz/controllers/quiz_progress_ctrl.dart';
import 'package:quizzle/features/quiz/widgets/options.dart';
import 'package:quizzle/models/quiz_settings.dart';
import 'package:quizzle/shared/game_button.dart';
import 'package:sizer/sizer.dart';

class QuizScreen extends ConsumerStatefulWidget {
  final QuizCategory quizCategory;
  final Difficulty difficulty;
  const QuizScreen({
    required this.quizCategory,
    required this.difficulty,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  String? selectedOption;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ref
          .watch(
        quizQuestionsProvider(
          QuizSetting(
            difficulty: widget.difficulty,
            category: widget.quizCategory,
          ),
        ),
      )
          .when(
        data: (quiz) {
          final quizProgress = ref.watch(quizProgressNotifierProvider);
          return Column(
            children: [
              Text(quiz[quizProgress.index].question),
              ...quiz[quizProgress.index].options.map((option) {
                return OptionWidget(
                  option: option,
                  isSelected: ref
                      .read(quizProgressNotifierProvider.notifier)
                      .containsAnswer(option),
                  onPressed: () {
                    selectedOption = option;
                  },
                );
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GameButton(
                    label: "Next",
                    callback: () {
                      ref
                          .read(quizProgressNotifierProvider.notifier)
                          .answerQuestion(quizProgress.index, selectedOption!);
                      selectedOption = null;
                    },
                    height: 10.h,
                    width: 45.w,
                    buttonColor: Colors.blue,
                    labelColor: Colors.white,
                    labelFontSize: 20,
                  ),
                ],
              ),
            ],
          );
        },
        error: (error, _) {
          return const Center(
            child: Text("An error occured"),
          );
        },
        loading: () {
          return Center(
            child: SpinKitChasingDots(),
          );
        },
      ),
    );
  }
}
