import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzle/core/enums.dart';
import 'package:quizzle/utils/prompt_gen.dart';
import '../../../core/providers.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../../models/quiz.dart';

final quizRepoProvider = Provider((ref) {
  return QuizRepo(ref.watch(geminiProvider));
});

class QuizRepo {
  final GenerativeModel _generativeModel;

  QuizRepo(this._generativeModel);

  Future<List<Quiz>> getQuizQuestions(
    QuizCategory quizCategory,
    Difficulty difficulty,
  ) async {
    GenerateContentResponse? response;
    String prompt = generatePrompt(difficulty, quizCategory);
    try {
      response = await _generativeModel.generateContent([Content.text(prompt)]);
      List<dynamic> responseJson = jsonDecode(response.text!);
      return responseJson.map((json) => Quiz.fromJson(json)).toList();
    } on SocketException catch (_) {
      throw Exception("Please check your internet and try again");
    } catch (_) {
      throw Exception("An error occured");
    }
  }
}
