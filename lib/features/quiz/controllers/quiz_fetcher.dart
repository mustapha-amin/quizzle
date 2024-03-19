import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzle/features/quiz/repository/quiz_repo.dart';
import 'package:quizzle/models/quiz_state.dart';

import '../../../core/enums.dart';

final quizQuistionsCtrlProvider =
    StateNotifierProvider<QuizQuestionsCtrl, QuizzesState>((ref) {
  return QuizQuestionsCtrl(ref.watch(quizRepoProvider));
});

class QuizQuestionsCtrl extends StateNotifier<QuizzesState> {
  QuizRepo quizRepo;
  QuizQuestionsCtrl(this.quizRepo) : super(QuizzesState.initial());

  void fetchQuestions(QuizCategory category, QuizDifficulty difficulty) async {
    state = QuizzesState.initial().copyWith(isLoading: true);
    try {
      final questions = await quizRepo.getQuizQuestions(
        category,
        difficulty,
      );
      log("Questions length${questions.length}");
      state = state.copyWith(isLoading: false, quizzes: questions);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
