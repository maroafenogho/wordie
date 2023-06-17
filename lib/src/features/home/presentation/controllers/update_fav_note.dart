import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/auth/presentation/controllers/current_user.dart';
import 'package:wordie/src/features/home/presentation/controllers/notes_controller.dart';

final asyncUpdateFavProvider =
    AsyncNotifierProvider<AsyncUpdateFavNoteNotifier, bool>(
  () => AsyncUpdateFavNoteNotifier(),
);

class AsyncUpdateFavNoteNotifier extends AsyncNotifier<bool> {
  @override
  FutureOr<bool> build() {
    throw UnimplementedError();
  }

  Future<bool> updateFavNote(
      {required String oldTitle, required bool isFav}) async {
    bool success = false;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      success = await ref.read(notesRepoProvider).updateFavNote(
          userId: ref.watch(currentUserProvider).value!.userId,
          oldTitle: oldTitle,
          isFav: isFav);
      return success;
    });
    if (state.hasError) {
      state = AsyncValue.error(state.error!, state.stackTrace!);

      log(state.stackTrace!.toString());
    }
    return success;
  }
}
