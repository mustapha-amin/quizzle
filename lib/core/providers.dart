import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../env/env.dart';

final geminiProvider = Provider((ref) {
  return GenerativeModel(model: "gemini-pro", apiKey: Env.apiKey);
});

final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);

final googleSignInProvider = Provider((ref) => GoogleSignIn());