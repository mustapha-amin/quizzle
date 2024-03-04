import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzle/features/quiz/repository/quiz_repo.dart';
import 'package:quizzle/models/quiz.dart';
import 'package:quizzle/models/quiz_settings.dart';

final quizQuestionsProvider =
    FutureProvider.family<List<Quiz>, QuizSetting>((ref, quizSetting) async {
  final quizRepo = ref.watch(quizRepoProvider);
  return quizRepo.getQuizQuestions(
    quizSetting.category,
    quizSetting.difficulty,
  );
});
