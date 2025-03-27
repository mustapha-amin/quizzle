import 'dart:math';

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
  math,
}

enum AIModel {
  deepseek("deepseek/deepseek-r1-zero:free"),
  qwen("qwen/qwq-32b:free"),
  meta("meta-llama/llama-3.3-70b-instruct:free");

  const AIModel(this.name);
  final String name;
}

enum QuizRemark {
  poor("Needs Improvement!", "Poor"),
  fair("You can do better!", "Fair"),
  good("Good job!", "Good"),
  veryGood("Very good, keep it up!", "Very good"),
  excellent("Excellent! You aced it!", "Excellent");

  const QuizRemark(this.message, this.name);
  final String message;
  final String name;
}

String generateRandomModel() {
  return AIModel.values.elementAt(Random().nextInt(3)).name;
}
