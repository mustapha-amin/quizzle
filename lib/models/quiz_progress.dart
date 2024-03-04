class QuizProgress {
  final int index;
  final List<String> selectedAnswers;

  QuizProgress({required this.index, required this.selectedAnswers});

  QuizProgress copyWith({int? index, List<String>? selectedAnswers}) {
    return QuizProgress(
      index: index ?? this.index,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
    );
  }

  QuizProgress addToAnswers(String answer) {
    QuizProgress quizProgress = copyWith(
      selectedAnswers: [...selectedAnswers, answer],
    );
    return quizProgress;
  }
}
