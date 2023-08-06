import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/auth/domain/usecases/usecases.dart';

final asyncLogoutProvider = AsyncNotifierProvider<AsyncLogoutNotifier, bool>(
  () => AsyncLogoutNotifier(),
);

class AsyncLogoutNotifier extends AsyncNotifier<bool> {
  @override
  FutureOr<bool> build() {
    throw UnimplementedError();
  }

  Future<bool> logout() async {
    bool success = false;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      success = await ref.read(authUsecaseProvider).executeLogout();
      return success;
    });
    if (state.hasError) {
      state = AsyncValue.error(state.error!, state.stackTrace!);
    }
    return success;
  }
}
