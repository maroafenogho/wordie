import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/auth/domain/user.dart';

import '../../data/repo/auth_repo.dart';

final currentUserProvider =
    StreamProvider((ref) => ref.watch(authRepoProvider).currentUser);
final authRepoProvider = Provider((ref) => AuthRepo());
final showPasswordProvider = StateProvider<bool>((ref) => false);
final asyncSignUpProvider = AsyncNotifierProvider<AsyncSignUpNotifier, User?>(
  () => AsyncSignUpNotifier(),
);

final asyncLoginProvider = AsyncNotifierProvider<AsyncLoginNotifier, User?>(
  () => AsyncLoginNotifier(),
);

class AsyncLoginNotifier extends AsyncNotifier<User?> {
  @override
  FutureOr<User?> build() {
    throw UnimplementedError();
  }

  Future<User?> login(String email, String password) async {
    User? user;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      user = await ref.read(authRepoProvider).login(email, password);
      return user;
    });
    if (state.hasError) {
      state = AsyncValue.error(state.error!, state.stackTrace!);

      log(state.stackTrace!.toString());
    }
    return user;
  }
}

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
      return user;
    });
    if (state.hasError) {
      state = AsyncValue.error(state.error!, state.stackTrace!);

      log(state.stackTrace!.toString());
    }
    return user;
  }
}
