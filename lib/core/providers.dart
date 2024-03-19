import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizzle/features/auth/repository/user_data_repo.dart';

final geminiProvider = Provider((ref) {
  return GenerativeModel(model: "gemini-pro", apiKey: dotenv.env["API_KEY"]!);
});

final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);

final googleSignInProvider = Provider((ref) => GoogleSignIn());

final currentUserProvider = StreamProvider((ref) {
  final userDataRepo = ref.watch(userDataRepoProvider);
  return userDataRepo.fetchUserData();
});

final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);
