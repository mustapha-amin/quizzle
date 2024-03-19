import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizzle/core/typedefs.dart';
import 'package:quizzle/models/user.dart' as k;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers.dart';

final userDataRepoProvider = Provider((ref) {
  return UserDataRepo(
    firebaseFirestore: ref.watch(firestoreProvider),
    firebaseAuth: ref.watch(firebaseAuthProvider),
  );
});

class UserDataRepo {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  UserDataRepo({required this.firebaseFirestore, required this.firebaseAuth});

  FutureVoid saveUserData(String username, String avatarUrl) async {
    try {
      k.User user = k.User(
        id: firebaseAuth.currentUser!.uid,
        username: username,
        email: firebaseAuth.currentUser!.email,
        avatar: avatarUrl,
        allTimeScores: 0,
      );
      await firebaseFirestore
          .collection("users")
          .doc(user.id)
          .set(user.toJson());
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }

  Stream<k.User?> fetchUserData() {
    return firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .snapshots()
        .map((snap) => k.User.fromJson(snap.data()!));
  }

  FutureVoid saveScore(int score) async {
    try {
      await firebaseFirestore
          .collection("users")
          .doc(firebaseAuth.currentUser!.uid)
          .update({
        "allTimeScore": FieldValue.increment(score),
        "gamesPlayed": FieldValue.increment(1),
      });
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }
}
