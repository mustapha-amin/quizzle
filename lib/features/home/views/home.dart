import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzle/core/providers.dart';

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
  void initState() {
    AppLifecycleListener(onStateChange: (state) {
      log(state.name);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ref.watch(firebaseAuthProvider).currentUser!.isAnonymous
              ? const SizedBox()
              : const CircleAvatar(),
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Text("Available game rooms"),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: null,
            tooltip: "game options",
            onPressed: _toggleFab,
            child: Icon(_fabExpanded ? Icons.close : Icons.add),
          ),
          FloatingActionButton(
            heroTag: null,
            tooltip: "single player",
            onPressed: () {},
            child: const Icon(Icons.person),
          ),
          FloatingActionButton(
            heroTag: null,
            tooltip: "multiplayer",
            onPressed: () {},
            child: const Icon(Icons.people),
          ),
        ],
      ),
    );
  }
}
