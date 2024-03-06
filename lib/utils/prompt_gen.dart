import 'package:quizzle/core/enums.dart';

String generatePrompt(QuizDifficulty difficulty, QuizCategory quizCategory) {
  return """Ignore all previous instructions
  You're an expert at creating quiz questions for educational games and you've been in the game for a decade
  Generate a list of 20 questions within ${quizCategory.name} category with difficulty set to ${difficulty.name} where we have easy, medium and hard
  Your response should be in a json format like this:
   [
    {
      "question" : "THE QUESTION HERE",
      "options" : ["OPTIONS", "HERE"],
      "answer" : "ANSWER HERE",
    },
    ...
   ]
    """;
}
