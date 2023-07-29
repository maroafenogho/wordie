import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/auth/data/repo/auth_repo.dart';
import 'package:wordie/src/features/auth/domain/user.dart';

final asyncLoginProvider = AsyncNotifierProvider<AsyncLoginNotifier, AppUser?>(
  () => AsyncLoginNotifier(),
);

class AsyncLoginNotifier extends AsyncNotifier<AppUser?> {
  @override
  FutureOr<AppUser?> build() {
    throw UnimplementedError();
  }

  Future<AppUser?> login(String email, String password) async {
    AppUser? user;
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
