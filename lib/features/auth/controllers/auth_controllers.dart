import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzle/features/auth/repository/auth_repo.dart';
import 'package:quizzle/models/auth_state.dart';

final authControllerNotifierProvider =
    StateNotifierProvider<AuthControllerNotifier, AuthState>((ref) {
  return AuthControllerNotifier(ref.watch(authRepoProvider));
});

class AuthControllerNotifier extends StateNotifier<AuthState> {
  AuthRepo authRepo;
  AuthControllerNotifier(this.authRepo) : super(AuthState.initial());

  void signInGoogle() async {
    state = state.copyWith(isLoading: true);
    try {
      final userCred = await authRepo.googleLogin();
      state = state.copyWith(isLoading: false, userCredential: userCred);
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
}
