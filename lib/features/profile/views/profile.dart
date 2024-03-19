import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzle/core/providers.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Hero(
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
          )
        ],
      ),
    );
  }
}
