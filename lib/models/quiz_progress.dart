import 'package:quizzle/core/typedefs.dart';

class QuizProgress {
  final int index;
  final List<String?> selectedAnswers;
  final ScoreAndRemark? scoreAndRemark;

  QuizProgress({
    required this.index,
    required this.selectedAnswers,
    required this.scoreAndRemark,
  });

  QuizProgress copyWith({
    int? index,
    List<String?>? selectedAnswers,
    ScoreAndRemark? scoreAndRemark,
  }) {
    return QuizProgress(
      index: index ?? this.index,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      scoreAndRemark: scoreAndRemark ?? this.scoreAndRemark,
    );
  }
}
