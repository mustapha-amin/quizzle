import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:quizzle/core/enums.dart';
import 'package:quizzle/core/providers.dart';
import 'package:quizzle/features/game%20mode/widgets/game_mode_widget.dart';
import 'package:quizzle/features/quiz/controllers/quiz_fetcher.dart';
import 'package:quizzle/features/quiz/views/quiz_screen.dart';
import 'package:quizzle/utils/dialog.dart';
import 'package:quizzle/utils/extensions.dart';

import '../../../utils/textstyle.dart';

final quizCategoryProvider = StateProvider<QuizCategory?>((ref) {
  return null;
});

class GameMode extends ConsumerStatefulWidget {
  QuizCategory? quizCategory;
  QuizDifficulty? quizDifficulty;
  GameMode({this.quizCategory, this.quizDifficulty, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameModeState();
}

class _GameModeState extends ConsumerState<GameMode> {
  @override
  Widget build(BuildContext context) {
    ref.listen(quizQuistionsCtrlProvider, (_, next) {
      if (next.quizzes!.isNotEmpty) {
        context.push(const QuizScreen());
      }
      if (next.error!.isNotEmpty) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(next.error!),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    ref.read(quizQuistionsCtrlProvider.notifier).fetchQuestions(
                          widget.quizCategory!,
                          widget.quizDifficulty!,
                        );
                  },
                  child: const Text("Retry"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel"),
                )
              ],
            );
          },
        );
      }
    });
    return PopScope(
      canPop: !ref.watch(quizQuistionsCtrlProvider).isLoading!,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: AbsorbPointer(
          absorbing: ref.watch(quizQuistionsCtrlProvider).isLoading!,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                spacing: 50,
                children: [
                  Text("Select a game mode",
                      style: kTextStyle(25, isBold: true)),
                  Column(
                    spacing: 32,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GameModeWidget(
                        iconData: Iconsax.user,
                        label: "Single player",
                        onTap: () {
                          ref.read(quizCategoryProvider.notifier).state =
                              widget.quizCategory;
                          ref
                              .read(quizQuistionsCtrlProvider.notifier)
                              .fetchQuestions(
                                widget.quizCategory!,
                                widget.quizDifficulty!,
                              );
                        },
                      ),
                      GameModeWidget(
                        iconData: Iconsax.profile_2user,
                        label: "1 v 1",
                        onTap: () {
                          if (ref
                              .watch(firebaseAuthProvider)
                              .currentUser!
                              .isAnonymous) {
                            showCustomDialog(
                              context: context,
                              title: "Multiplayer",
                              message: "Sign in to play multiplayer mode",
                            );
                          }
                        },
                      ),
                    ],
                  ).centralize(),
                ],
              ),
              Center(
                child: switch (ref.watch(quizQuistionsCtrlProvider).isLoading) {
                  true => SpinKitChasingDots(
                      size: 80,
                      color: Theme.of(context).primaryColor,
                      duration: const Duration(milliseconds: 800),
                    ),
                  _ => const SizedBox()
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
