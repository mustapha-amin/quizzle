import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzle/core/providers.dart';
import 'package:quizzle/features/auth/controllers/user_data_controller.dart.dart';
import 'package:quizzle/features/auth/repository/auth_repo.dart';
import 'package:quizzle/features/quiz/views/quiz_categories.dart';
import 'package:quizzle/models/auth_state.dart';

final authControllerNotifierProvider =
    StateNotifierProvider<AuthControllerNotifier, AuthState>((ref) {
  return AuthControllerNotifier(ref.watch(authRepoProvider), ref.watch(firestoreProvider));
});

class AuthControllerNotifier extends StateNotifier<AuthState> {
  AuthRepo authRepo;
  FirebaseFirestore firebaseFirestore;
  AuthControllerNotifier(this.authRepo, this.firebaseFirestore)
      : super(AuthState.initial());

  void signInGoogle(BuildContext context, WidgetRef ref) async {
    state = state.copyWith(isLoading: true);
    try {
      final userCred = await authRepo.googleLogin();
      final doc = await firebaseFirestore
          .collection("users")
          .doc(userCred.user!.uid)
          .get();
      if (!doc.exists) {
        ref
            .read(userDataControllerProvider.notifier)
            .saveUserData(userCred.user!.displayName!);
      }
      state = state.copyWith(isLoading: false, userCredential: userCred);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const QuizCategories();
      }));
    } catch (e, _) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void signOutGoogle() async {
    state = state.copyWith(isLoading: true);
    try {
      await authRepo.googleSignOut();
      state = state.copyWith(isLoading: false, userCredential: null);
    } catch (e, _) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void signInAnon() async {
    state = state.copyWith(isLoading: true);
    try {
      final userCred = await authRepo.signInAnon();
      state = state.copyWith(isLoading: false, userCredential: userCred);
    } catch (e, _) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
