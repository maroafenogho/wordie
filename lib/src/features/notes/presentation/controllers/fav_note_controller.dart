import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/auth/presentation/controllers/current_user.dart';
import 'package:wordie/src/features/notes/application/notes_service.dart';

final asyncUpdateFavNoteProvider =
    AutoDisposeAsyncNotifierProvider<AsyncUpdateFavNoteNotifier, bool>(
  () => AsyncUpdateFavNoteNotifier(),
);

class AsyncUpdateFavNoteNotifier extends AutoDisposeAsyncNotifier<bool> {
  @override
  FutureOr<bool> build() {
    return false;
  }

  Future<bool> updateFavNote(
      {required bool isFav, required String noteId}) async {
    final user = ref.watch(currentUserProvider).value;
    if (user == null) {
      throw AssertionError('User cannot be null');
    }
    bool success = false;
    state = await AsyncValue.guard(() async {
      success = await ref
          .watch(noteServiceProvider)
          .updateFavNote(userId: user.userId, noteId: noteId, isFav: isFav);
      return success;
    });
    if (state.hasError) {
      state = AsyncValue.error(state.error!, state.stackTrace!);

      log(state.stackTrace!.toString());
    }
    return success;
  }
}
