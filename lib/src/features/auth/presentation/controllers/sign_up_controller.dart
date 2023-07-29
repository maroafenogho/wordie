import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/auth/data/repo/auth_repo.dart';
import 'package:wordie/src/features/auth/domain/user.dart';

final asyncSignUpProvider =
    AsyncNotifierProvider<AsyncSignUpNotifier, AppUser?>(
  () => AsyncSignUpNotifier(),
);

class AsyncSignUpNotifier extends AsyncNotifier<AppUser?> {
  @override
  FutureOr<AppUser?> build() {
    throw UnimplementedError();
  }

  Future<AppUser?> signUp(
      {required String email,
      required String password,
      required String firstName,
      required String lastName}) async {
    AppUser? user;
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
