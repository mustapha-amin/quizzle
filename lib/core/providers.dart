import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizzle/core/env.dart';
import 'package:quizzle/features/auth/repository/user_data_repo.dart';

// final geminiProvider = Provider((ref) {
//   return GenerativeModel(model: "gemini-pro", apiKey: "AIzaSyCfYN2lf-Ywr04vXXJBEmBYuRzt45h__SM");
// });

final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(
    baseUrl: "https://openrouter.ai/api/v1",
    headers: {
      "Authorization": "Bearer ${Env.deepseekApiKey}",
      'Content-Type': 'application/json',
      'temperature': 0.7,
    },
  ))
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log("--> ${options.method} ${options.path}");
          log(options.data.toString());
          return handler.next(options);
        },
        onResponse: (response, handler) {
          log("<-- ${response.statusCode} ${response.data}");
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          log("<-- Error: ${e.type}");
          return handler.next(e);
        },
      ),
    );
});

final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);

final googleSignInProvider = Provider((ref) => GoogleSignIn());

final currentUserProvider = StreamProvider((ref) {
  final userDataRepo = ref.watch(userDataRepoProvider);
  return userDataRepo.fetchUserData();
});

final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);
