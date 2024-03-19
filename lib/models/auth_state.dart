import 'package:firebase_auth/firebase_auth.dart';

class AuthState {
  UserCredential? userCredential;
  bool? isLoading;
  String? error;

  AuthState({this.userCredential, this.isLoading, this.error});

  AuthState copyWith({
    UserCredential? userCredential,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      userCredential: userCredential ?? this.userCredential,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  factory AuthState.initial() {
    return AuthState(
      userCredential: null,
      isLoading: false,
      error: '',
    );
  }
}

