import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzle/core/enums.dart';
import 'package:quizzle/features/quiz/controllers/quiz_fetcher.dart';
import 'package:quizzle/models/quiz_progress.dart';

final quizProgressNotifierProvider =
    StateNotifierProvider.autoDispose<QuizProgressNotifier, QuizProgress>((ref) {
  return QuizProgressNotifier(
    ref.watch(quizQuistionsCtrlProvider.notifier),
  );
});

class QuizProgressNotifier extends StateNotifier<QuizProgress> {
  QuizQuestionsCtrl quizQuestionsCtrl;
  QuizProgressNotifier(
    this.quizQuestionsCtrl,
  ) : super(
          QuizProgress(
            index: 0,
            selectedAnswers: List.generate(20, (_) => null),
            scoreAndRemark: null,
          ),
        );

  void next() {
    if (state.index < 19) {
      state = state.copyWith(
          index: state.index + 1, selectedAnswers: state.selectedAnswers);
    }
  }

  void prev() {
    if (state.index > 0) {
      state = state.copyWith(
          index: state.index - 1, selectedAnswers: state.selectedAnswers);
    }
  }

  void computeScore() {
    int score = 0;
    QuizRemark? quizRemark;
    final correctAnswers =
        quizQuestionsCtrl.state.quizzes!.map((e) => e.answer);
    final selectedAnswers = state.selectedAnswers;

    for (final answer in selectedAnswers) {
      if (correctAnswers.contains(answer)) {
        score++;
      }
    }

    if (score <= 5) {
      quizRemark = QuizRemark.poor;
    } else if (score > 5 && score <= 10) {
      quizRemark = QuizRemark.fair;
    } else if (score > 10 && score <= 15) {
      quizRemark = QuizRemark.good;
    } else if (score > 15 && score <= 19) {
      quizRemark = QuizRemark.veryGood;
    } else {
      quizRemark = QuizRemark.excellent;
    }

    state = state.copyWith(scoreAndRemark: (score, quizRemark));
  }

  void answerQuestion(int index, String answer) {
    final answers = state.selectedAnswers;
    answers[index] = answer;
    state = state.copyWith(selectedAnswers: answers);
  }

  int get currentIndex => state.index;

  bool answerIsSelected(String answer, int index) =>
      state.selectedAnswers[index] == answer;

  bool answerSlotNotEmpty(int index) => state.selectedAnswers[index] != null;

}
