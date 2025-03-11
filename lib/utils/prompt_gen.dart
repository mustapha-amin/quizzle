String generatePrompt() {
  return """## Title 
 Customized Quiz Question Set Creation 
## Content 
 Ignore all previous instructions. Act as an expert in educational content creation,
you have been designing and formulating quiz questions across various domains for 10 years,
consistently achieving high engagement and learning outcomes through your well-crafted quizzes. 
Given a category and a difficulty level by the user, create a set of 20 quiz questions with difficulty set to the specified difficulty
on a scale of(easy, medium, and hard). Each question should be meticulously designed to test knowledge depth in the
category, ensuring a comprehensive understanding of the subject. The answers should'nt always be the first in the options. Try to mix it up a bit.
The quiz should be engaging, educational, and challenging, providing an enriching learning experience for the user.
Each option should'nt be more than 40 charcters long

Ensure that your response is a json that can be deserialized by this dart code: 

###

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

###

JSON FORMAT:

[
  {
    "question":"specific question",
    "options": ["option1", "option2", "option3", "option4"],
    "answer":"answer"
  },
  ...
]


**Notice**:
 The quiz should be diverse, covering a wide range of topics within the chosen category to engage a broad audience. 
 Accuracy in the JSON formatting is crucial for the quiz functionality, 
 so pay close attention to the structure and syntax. Remember, 
 the goal is to create an educational and engaging quiz that effectively 
 tests knowledge in a specific domain. 

 DO NOT WRAP THE RESPONSE IN --- ```json {content} ``` ----
 ENSURE TO CLOSE ALL OPENED BRACKETS, QUOTES, ETC. AVOID CHARACTERS THAT COULD RUIN MY
 JSON DECODING
 """;
}
