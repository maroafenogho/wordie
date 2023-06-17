import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/auth/domain/user.dart';
import 'package:wordie/src/features/auth/presentation/controllers/auth_controller.dart';

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
    }
    return user;
  }
}
