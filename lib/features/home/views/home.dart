import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzle/core/providers.dart';
import 'package:quizzle/features/quiz/views/quiz_categories.dart';
import 'package:quizzle/utils/dialog.dart';
import 'package:quizzle/utils/extensions.dart';

import '../../../utils/textstyle.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  bool _fabExpanded = false;

  void _toggleFab() {
    setState(() {
      _fabExpanded = !_fabExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Available game rooms",
          style: kTextStyle(17, color: Colors.black),
        ),
        actions: [
          ref.watch(firebaseAuthProvider).currentUser == null
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
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (_fabExpanded)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Single player",
                      style: kTextStyle(12, color: Colors.black),
                    ),
                    const SizedBox(width: 5),
                    FloatingActionButton(
                      heroTag: null,
                      tooltip: "single player",
                      onPressed: () {
                        context.push(const QuizCategories());
                      },
                      child: const Icon(Icons.person),
                    ),
                  ],
                ).padY(7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Multiplayer",
                      style: kTextStyle(12, color: Colors.black),
                    ),
                    const SizedBox(width: 5),
                    FloatingActionButton(
                      heroTag: null,
                      tooltip: "multiplayer",
                      onPressed: () {
                        final user =
                            ref.watch(firebaseAuthProvider).currentUser;
                        if (user == null) {
                        } else {
                          context.push(const QuizCategories());
                        }
                      },
                      child: const Icon(Icons.people),
                    ),
                  ],
                ).padY(7),
              ],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: null,
                tooltip: "game options",
                onPressed: _toggleFab,
                child: Icon(_fabExpanded ? Icons.close : Icons.add),
              ),
            ],
          ).padY(7),
        ],
      ),
    );
  }
}
