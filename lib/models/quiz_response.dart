import 'package:quizzle/models/quiz.dart';

class QuizResponse {
  List<Quiz>? quizQuestions;
  bool? isLoading;
  String? error;

  QuizResponse({this.quizQuestions, this.isLoading, this.error});

  factory QuizResponse.initial() {
    return QuizResponse(
      quizQuestions: [],
      error: '',
      isLoading: false,
    );
  }

  QuizResponse copyWith({
    List<Quiz>? quizQuestions,
    bool? isLoading,
    String? error,
  }) {
    return QuizResponse(
      quizQuestions: quizQuestions ?? this.quizQuestions,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
