import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart' show SpinKitChasingDots;
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:quizzle/core/enums.dart';
import 'package:quizzle/core/providers.dart';
import 'package:quizzle/features/auth/controllers/auth_controllers.dart';
import 'package:quizzle/features/game%20mode/widgets/game_mode_widget.dart';
import 'package:quizzle/features/quiz/controllers/quiz_fetcher.dart';
import 'package:quizzle/features/quiz/views/quiz_categories.dart';
import 'package:quizzle/features/quiz/views/quiz_screen.dart';
import 'package:quizzle/utils/dialog.dart';
import 'package:quizzle/utils/extensions.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/textstyle.dart';

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
        showCustomDialog(
          context: context,
          title: "Error",
          message: next.error!,
        );
      }
    });
    return Scaffold(
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
                Text("Select a game mode", style: kTextStyle(25, isBold: true)),
                Column(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GameModeWidget(
                      img: "assets/images/single.png",
                      label: "Single player",
                      onTap: () {
                        ref
                            .read(quizQuistionsCtrlProvider.notifier)
                            .fetchQuestions(
                              widget.quizCategory!,
                              widget.quizDifficulty!,
                            );
                      },
                    ),
                    GameModeWidget(
                      img: "assets/images/multi.jpg",
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
    );
  }
}
