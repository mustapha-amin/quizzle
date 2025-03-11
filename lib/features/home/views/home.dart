import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:quizzle/core/providers.dart';
import 'package:quizzle/features/home/widgets/game_mode.dart';
import 'package:quizzle/features/quiz/views/quiz_categories.dart';
import 'package:quizzle/features/quiz/views/quiz_screen.dart';
import 'package:quizzle/utils/dialog.dart';
import 'package:quizzle/utils/extensions.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/textstyle.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  bool _fabExpanded = false;

  // void _toggleFab() {
  //   setState(() {
  //     _fabExpanded = !_fabExpanded;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // title: Text(
        //   "Available game rooms",
        //   style: kTextStyle(17, color: Colors.black),
        // ),
        actions: [
          ref.watch(firebaseAuthProvider).currentUser == null ||
                  ref.watch(firebaseAuthProvider).currentUser!.isAnonymous
              ? const SizedBox()
              : Hero(
                  tag: 'avatar',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: ref.watch(currentUserProvider).when(
                          data: (user) => Image.network(user!.avatar!),
                          error: (_, __) => const Icon(Icons.error),
                          loading: () => const CircularProgressIndicator(),
                        ),
                  ),
                ),
        ],
      ),
      body: Column(
        spacing: 50,
        children: [
          Text("Select a game mode", style: kTextStyle(25, isBold: true)),
          Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GameMode(
                img: "assets/images/single.png",
                label: "Single player",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QuizCategories(),
                    ),
                  );
                },
              ),
              GameMode(
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
    );
  }
}
