import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/home/presentation/controllers/notes_controller.dart';

final asyncUpdateProvider =
    AsyncNotifierProvider<AsyncUpdateNoteNotifier, bool>(
  () => AsyncUpdateNoteNotifier(),
);

class AsyncUpdateNoteNotifier extends AsyncNotifier<bool> {
  @override
  FutureOr<bool> build() {
    throw UnimplementedError();
  }

  Future<bool> updateNote({
    required String userId,
    required String noteId,
    required String newTitle,
    required String newBody,
  }) async {
    bool success = false;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      success = await ref.read(notesRepoProvider).updateNote(
          userId: userId, noteId: noteId, newTitle: newTitle, newBody: newBody);
      return success;
    });
    if (state.hasError) {
      state = AsyncValue.error(state.error!, state.stackTrace!);

      log(state.stackTrace!.toString());
    }
    return success;
  }
}
