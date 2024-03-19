import 'dart:convert';
import 'dart:developer';
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
    QuizDifficulty difficulty,
  ) async {
    GenerateContentResponse? response;
    String prompt = generatePrompt(difficulty, quizCategory);
    log(prompt);
    try {
      response = await _generativeModel.generateContent([Content.text(prompt)]);
      log(response.text!);
      List<dynamic> responseJson = jsonDecode(response.text!);
      log(responseJson.toString());
      return responseJson.map((json) => Quiz.fromJson(json)).toList();
    } on SocketException catch (_) {
      log("Please check your internet and try again");
      throw Exception("Please check your internet and try again");
    } on GenerativeAIException catch (e) {
      log(e.toString());
      throw Exception("An error occured: ${e.message}");
    } on FormatException catch (e) {
      log(e.source);
      log(e.toString());
      throw Exception("An error occured: ${e.message}");
    } catch (e) {
      log(e.toString());
      throw Exception("An error occured: ${e.toString()}");
    }
  }
}
