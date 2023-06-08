import 'dart:async';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/game/data/repo/note_repo.dart';

final firebaseDbRefProvider = Provider((ref) => FirebaseDatabase.instance);

final firebaseDbInstance = Provider((ref) => FirebaseDatabase.instance);

final notesRepoProvider = Provider((ref) => NoteRepo(ref: ref));

final asyncAddNoteProvider =
    AsyncNotifierProvider<AsyncCreateNoteNotifier, bool>(
  () => AsyncCreateNoteNotifier(),
);

class AsyncCreateNoteNotifier extends AsyncNotifier<bool> {
  @override
  FutureOr<bool> build() {
    throw UnimplementedError();
  }

  Future<bool> creatNote(
      {required String userId,
      required String noteTitle,
      required String noteBody}) async {
    bool success = false;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      success = await ref
          .watch(notesRepoProvider)
          .createNote(userId: userId, noteTitle: noteTitle, noteBody: noteBody);
      return success;
    });
    if (state.hasError) {
      state = AsyncValue.error(state.error!, state.stackTrace!);

      log(state.stackTrace!.toString());
    }
    return success;
  }
}
