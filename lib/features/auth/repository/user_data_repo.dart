import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:quizzle/core/typedefs.dart';
import 'package:quizzle/models/user.dart' as k;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzle/models/user.dart';
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

  FutureVoid saveUserData(String username) async {
    try {
      k.User user = k.User(
        id: firebaseAuth.currentUser!.uid,
        username: username,
        email: firebaseAuth.currentUser!.email,
        highScores: {},
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

  Future<k.User> fetchUserDataFuture() async {
    final doc = await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .get();
    return k.User.fromJson(doc.data()!);
  }

  FutureVoid saveScore(int score, String category) async {
    try {
      User user = await fetchUserDataFuture();
     if(user.highScores![category] == null || user.highScores![category]! < score){
       user.highScores![category] = score;
     }
      await firebaseFirestore
          .collection("users")
          .doc(firebaseAuth.currentUser!.uid)
          .update(user.toJson());
    } catch (e, stk) {
      log(e.toString(), stackTrace: stk);
      throw Exception(e.toString());
    }
  }
}
