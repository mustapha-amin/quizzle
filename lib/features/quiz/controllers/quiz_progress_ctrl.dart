import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzle/models/quiz_progress.dart';

final quizProgressNotifierProvider =
    StateNotifierProvider<QuizProgressNotifier, QuizProgress>((ref) {
  return QuizProgressNotifier();
});

class QuizProgressNotifier extends StateNotifier<QuizProgress> {
  QuizProgressNotifier() : super(QuizProgress(index: 0, selectedAnswers: []));

  void next() {
    if (state.index < 19) {
      state = state.copyWith(
          index: state.index + 1, selectedAnswers: state.selectedAnswers);
    }
  }

  void answerQuestion(int index, String answer) {
    state = state.addToAnswers(answer);
  }

  int get currentIndex => state.index;

  bool containsAnswer(String answer) => state.selectedAnswers.contains(answer);
}
