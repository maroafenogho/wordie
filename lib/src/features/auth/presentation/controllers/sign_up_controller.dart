import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/auth/domain/user.dart';
import 'package:wordie/src/features/auth/presentation/controllers/auth_controller.dart';

final asyncSignUpProvider = AsyncNotifierProvider<AsyncSignUpNotifier, User?>(
  () => AsyncSignUpNotifier(),
);

class AsyncSignUpNotifier extends AsyncNotifier<User?> {
  @override
  FutureOr<User?> build() {
    throw UnimplementedError();
  }

  Future<User?> signUp(
      {required String email,
      required String password,
      required String firstName,
      required String lastName}) async {
    User? user;
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
