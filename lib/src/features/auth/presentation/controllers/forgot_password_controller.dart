import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/auth/domain/usecases/usecases.dart';

final asyncResetPasswordProvider =
    AsyncNotifierProvider<AsyncForgotPasswordNotifier, bool>(
  () => AsyncForgotPasswordNotifier(),
);

class AsyncForgotPasswordNotifier extends AsyncNotifier<bool> {
  @override
  FutureOr<bool> build() {
    throw UnimplementedError();
  }

  Future<bool> resetPassword(String email) async {
    bool success = false;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      success = await ref.read(authUsecaseProvider).executePasswordReset(email);
      return success;
    });
    if (state.hasError) {
      state = AsyncValue.error(state.error!, state.stackTrace!);
    }
    return success;
  }
}
