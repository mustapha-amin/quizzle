import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzle/core/typedefs.dart';
import 'package:quizzle/features/auth/repository/user_data_repo.dart';
import 'package:quizzle/models/user.dart';

enum Status {
  idle,
  data,
  loading,
  error,
}

final userDataControllerProvider =
    StateNotifierProvider<UserDataNotifier, Status>((ref) {
  return UserDataNotifier(ref.watch(userDataRepoProvider));
});

class UserDataNotifier extends StateNotifier<Status> {
  UserDataRepo userDataRepo;
  UserDataNotifier(this.userDataRepo) : super(Status.idle);

  FutureVoid saveUserData(String username, String avatarUrl) async {
    try {
      state = Status.loading;
      await userDataRepo.saveUserData(username, avatarUrl);
      state = Status.data;
    } catch (e) {
      state = Status.error;
    }
  }

  FutureVoid saveScore(
    int score,
    int categoryIndex,
    User user,
  ) async {
    try {
      state = Status.loading;
      await userDataRepo.saveScore(score, categoryIndex, user);
      state = Status.data;
    } catch (e) {
      state = Status.error;
    }
  }
}
