import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:quizzle/core/enums.dart';
import 'package:quizzle/utils/extensions.dart';
import 'package:quizzle/utils/textstyle.dart';

class ResultCard extends StatelessWidget {
  final QuizRemark quizRemark;
  final int score;
  const ResultCard({super.key, required this.quizRemark, required this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 168,
      width: double.infinity,
      decoration: ShapeDecoration(
        color: Colors.grey[900],
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius(
            cornerRadius: 24,
            cornerSmoothing: 0.6,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              Text(
                score.toString(),
                style: kTextStyle(
                  36,
                  isBold: true,
                  color: switch (quizRemark) {
                    QuizRemark.poor => Colors.red,
                    QuizRemark.fair => Colors.amber,
                    QuizRemark.good => Colors.amber[700],
                    QuizRemark.veryGood => Colors.green[400],
                    QuizRemark.excellent => Colors.green[800],
                  }!,
                ),
              ),
              Text(
                "of  20",
                style: kTextStyle(
                  25,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              Text(
                quizRemark.name,
                style: kTextStyle(
                  32,
                  isBold: true,
                  color: Colors.white,
                ),
              ),
              Text(
                quizRemark.message,
                style: kTextStyle(14, color: Colors.white),
              )
            ],
          ),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              switch (quizRemark) {
                QuizRemark.poor => "😒",
                QuizRemark.fair => "🙂",
                QuizRemark.good => "👌",
                QuizRemark.veryGood => "👏",
                QuizRemark.excellent => "🎊",
              },
              style: kTextStyle(40),
            ).centralize(),
          )
        ],
      ).padX(32),
    );
  }
}
