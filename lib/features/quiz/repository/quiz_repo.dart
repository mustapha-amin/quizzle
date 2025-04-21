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

  String? extractJsonString(String response) {
    final regex = RegExp(r'\[\s*{.*?}\s*]', dotAll: true);
    final match = regex.firstMatch(response);

    if (match != null) {
      return match.group(0);
    }

    return null;
  }

  Future<List<Quiz>> getQuizQuestions(
    QuizCategory quizCategory,
    QuizDifficulty difficulty,
  ) async {
    try {
      final response = await _dio.post(
        "/chat/completions",
        data: {
          "model": generateRandomModel(),
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
      final List<dynamic> responseJson = jsonDecode(extractJsonString(contentString)!);
      return responseJson.map((json) => Quiz.fromJson(json)).toList();
    } on SocketException catch (_) {
      log("Please check your internet and try again");
      throw "Please check your internet and try again";
    } on FormatException catch (e) {
      log(e.source);
      log(e.toString());
      throw "An unexpected error occured. Please try again.";
    } catch (e) {
      log(e.toString());
      throw "An unexpected error occured. Please try again.";
    }
  }
}
