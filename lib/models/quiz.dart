class Quiz {
  final String question;
  final List<String> options;
  final String answer;

  Quiz({
    required this.question,
    required this.options,
    required this.answer,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      question: json["question"],
      options: List.from(json["options"]),
      answer: json["answer"],
    );
  }
}
