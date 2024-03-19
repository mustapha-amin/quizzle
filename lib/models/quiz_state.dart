import 'package:quizzle/models/quiz.dart';

class QuizzesState {
  List<Quiz>? quizzes;
  bool? isLoading;
  String? error;

  QuizzesState({this.quizzes, this.isLoading, this.error});

  QuizzesState copyWith({
    List<Quiz>? quizzes,
    bool? isLoading,
    String? error,
  }) {
    return QuizzesState(
      quizzes: quizzes ?? this.quizzes,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  factory QuizzesState.initial() {
    return QuizzesState(
      quizzes: [],
      isLoading: false,
      error: '',
    );
  }
}
