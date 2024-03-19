enum QuizDifficulty {
  easy,
  medium,
  hard,
}

enum QuizCategory {
  general,
  science,
  computing,
  technology,
  health,
  history,
  gaming,
  movies,
  anime,
  books,
  sports,
}

enum QuizRemark {
  poor("Poor"),
  fair("Fair"),
  good("Good"),
  veryGood("Very good"),
  excellent("Excellent");

  const QuizRemark(this.message);
  final String message;
}
