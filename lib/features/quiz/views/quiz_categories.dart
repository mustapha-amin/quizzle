import 'package:flutter/material.dart';
import 'package:quizzle/core/enums.dart';

class QuizCategories extends StatelessWidget {
  const QuizCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text("Quiz categories"),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ...QuizCategory.values.map((category) {
                  return ListTile(
                    title: Text(category.name),
                  );
                })
              ],
            ),
          )
        ],
      ),
    );
  }
}
