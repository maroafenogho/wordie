import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'notes_controller.dart';

final asyncDeleteNoteProvider =
    AutoDisposeAsyncNotifierProvider<AsyncDeleteNoteNotifier, bool>(
  () => AsyncDeleteNoteNotifier(),
);

class AsyncDeleteNoteNotifier extends AutoDisposeAsyncNotifier<bool> {
  @override
  FutureOr<bool> build() {
    throw UnimplementedError();
  }

  Future<bool> deleteNote({
    required String userId,
    required String noteId,
  }) async {
    bool success = false;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      success = await ref.read(notesRepoProvider).deleteNote(
            userId: userId,
            noteId: noteId,
          );
      return success;
    });
    if (state.hasError) {
      state = AsyncValue.error(state.error!, state.stackTrace!);

      log(state.stackTrace!.toString());
    }
    return success;
  }
}
