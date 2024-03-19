import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzle/core/providers.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quizzle/core/typedefs.dart';

final authRepoProvider = Provider((ref) {
  return AuthRepo(
    firebaseAuth: ref.watch(firebaseAuthProvider),
    googleSignIn: ref.watch(googleSignInProvider),
  );
});

class AuthRepo {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  AuthRepo({required this.firebaseAuth, required this.googleSignIn});

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  FutureUserCred googleLogin() async {
    try {
      final googleAcct = await googleSignIn.signIn();

      final googleAuth = await googleAcct!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCred = await firebaseAuth.signInWithCredential(credential);
      return userCred;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  FutureVoid googleSignOut() async {
    try {
      await firebaseAuth.signOut();
      await googleSignIn.signOut();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  FutureVoid updateAvatar(String? url) async {
    await firebaseAuth.currentUser!.updatePhotoURL(url);
  }
}
