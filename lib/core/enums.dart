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
  poor("Poor"),
  fair("Fair"),
  good("Good"),
  veryGood("Very good"),
  excellent("Excellent");

  const QuizRemark(this.message);
  final String message;
}

String generateRandomModel() {
  return AIModel.values.elementAt(Random().nextInt(3)).name;
}
