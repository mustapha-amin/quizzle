import 'package:flutter_test/flutter_test.dart';
import 'package:quizzle/core/enums.dart';
import 'package:quizzle/utils/prompt_gen.dart';

const resp = """Ignore all previous instructions
  You're an expert at creating quiz questions for educational games and you've been in the game for a decade
  Generate a list of 20 questions within health category with difficulty set to medium where we have easy, medium and hard
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

void main() {
  test("Prompt generation test", () {
    expect(resp, generatePrompt(QuizDifficulty.medium, QuizCategory.health));
  });
}
