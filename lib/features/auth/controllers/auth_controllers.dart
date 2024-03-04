import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzle/features/auth/repository/auth_repo.dart';

final authControllerNotifierProvider =
    StateNotifierProvider<AuthControllerNotifier, AsyncValue<UserCredential?>>(
        (ref) {
  return AuthControllerNotifier(ref.watch(authRepoProvider));
});

class AuthControllerNotifier
    extends StateNotifier<AsyncValue<UserCredential?>> {
  AuthRepo authRepo;
  AuthControllerNotifier(this.authRepo) : super(const AsyncData(null));

  void signInAnon() async {
    state = const AsyncValue.loading();
    try {
      final userCred = await authRepo.signInAnon();
      state = AsyncValue.data(userCred);
    } catch (e, _) {
      state = AsyncValue.error(e, _);
    }
  }

  void signInGoogle() async {
    state = const AsyncLoading();
    try {
      final userCred = await authRepo.googleLogin();
      state = AsyncValue.data(userCred);
    } catch (e, _) {
      state = AsyncValue.error(e, _);
    }
  }

  void signOutGoogle() async {
    state = const AsyncLoading();
    try {
      await authRepo.googleSignOut();
      state = const AsyncData(null);
    } catch (e, _) {
      state = AsyncValue.error(e, _);
    }
  }
}
