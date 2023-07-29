import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/auth/presentation/controllers/current_user.dart';
import 'package:wordie/src/features/notes/data/repositories/notes_repository.dart';

final asyncAddNoteProvider =
    AutoDisposeAsyncNotifierProvider<AsyncCreateNoteNotifier, bool>(
  () => AsyncCreateNoteNotifier(),
);

class AsyncCreateNoteNotifier extends AutoDisposeAsyncNotifier<bool> {
  @override
  FutureOr<bool> build() {
    return false;
  }

  Future<bool> createNote(
      {required String noteTitle, required String noteBody}) async {
    final user = ref.watch(currentUserProvider).value;
    if (user == null) {
      throw AssertionError('User cannot be null');
    }
    bool success = false;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      success = await ref.watch(notesrepositoryProvider).createNote(
          userId: user.userId, noteTitle: noteTitle, noteBody: noteBody);
      return success;
    });
    if (state.hasError) {
      state = AsyncValue.error(state.error!, state.stackTrace!);

      log(state.stackTrace!.toString());
    }
    return success;
  }
}
