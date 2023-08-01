import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/auth/data/repo/auth_repo.dart';
import 'package:wordie/src/features/auth/domain/entity/user.dart';

final asyncSignUpProvider =
    AsyncNotifierProvider<AsyncSignUpNotifier, WordieUser?>(
  () => AsyncSignUpNotifier(),
);

class AsyncSignUpNotifier extends AsyncNotifier<WordieUser?> {
  @override
  FutureOr<WordieUser?> build() {
    throw UnimplementedError();
  }

  Future<WordieUser?> signUp(
      {required String email,
      required String password,
      required String firstName,
      required String lastName}) async {
    WordieUser? user;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      user = await ref.read(authRepoProvider).signUp(
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName);
      // await ref.read(notesRepoProvider).setDbRef(user!.userId);
      return user;
    });
    if (state.hasError) {
      state = AsyncValue.error(state.error!, state.stackTrace!);
    }
    return user;
  }
}
