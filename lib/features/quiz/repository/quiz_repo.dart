import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzle/core/enums.dart';
import 'package:quizzle/utils/prompt_gen.dart';
import '../../../core/providers.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../../models/quiz.dart';

final quizRepoProvider = Provider((ref) {
  return QuizRepo(ref.watch(dioProvider));
});

class QuizRepo {
  final Dio _dio;

  QuizRepo(this._dio);

  Future<List<Quiz>> getQuizQuestions(
    QuizCategory quizCategory,
    QuizDifficulty difficulty,
  ) async {
    try {
      final response = await _dio.post(
        "/chat/completions",
        data: {
          "model": "deepseek/deepseek-chat:free",
          "messages": [
            {"role": "system", "content": generatePrompt()},
            {
              "role": "user",
              "content":
                  "Category: ${quizCategory.name}, Difficulty: ${difficulty.name}"
            }
          ],
          "stream": false
        },
      );

      final contentString =
          response.data["choices"][0]["message"]["content"] as String;
      final List<dynamic> responseJson = jsonDecode(contentString);
      return responseJson.map((json) => Quiz.fromJson(json)).toList();
    } on SocketException catch (_) {
      log("Please check your internet and try again");
      throw Exception("Please check your internet and try again");
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
