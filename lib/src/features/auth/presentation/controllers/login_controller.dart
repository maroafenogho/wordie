import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/auth/data/repo/auth_repo.dart';
import 'package:wordie/src/features/auth/domain/entity/user.dart';

final asyncLoginProvider =
    AsyncNotifierProvider<AsyncLoginNotifier, WordieUser?>(
  () => AsyncLoginNotifier(),
);

class AsyncLoginNotifier extends AsyncNotifier<WordieUser?> {
  @override
  FutureOr<WordieUser?> build() {
    throw UnimplementedError();
  }

  Future<WordieUser?> login(String email, String password) async {
    WordieUser? user;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      user = await ref.read(authRepoProvider).login(email, password);
      return user;
    });
    if (state.hasError) {
      state = AsyncValue.error(state.error!, state.stackTrace!);
    }
    return user;
  }
}
