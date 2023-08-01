import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/auth/domain/entity/user.dart';
import 'package:wordie/src/features/auth/domain/usecases/login_usecase.dart';

class LoginController extends AutoDisposeAsyncNotifier<WordieUser?> {
  Future<WordieUser?> login(String email, String password) async {
    WordieUser? user;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      user = await ref.watch(authUsecaseProvider
          .select((value) => value.executeLogin(email, password)));

      return user;
    });
    if (state.hasError) {
      log(state.error!.toString());
      // log(state.stackTrace!.toString());
      state = AsyncValue.error(state.error!, state.stackTrace!);
    }
    return user;
  }

  @override
  FutureOr<WordieUser?> build() {
    return null;
  }
}

final loginContAsyncNotifier =
    AutoDisposeAsyncNotifierProvider<LoginController, WordieUser?>(
  () => LoginController(),
);
