import 'dart:async';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/auth/presentation/controllers/auth_controller.dart';
import 'package:wordie/src/features/home/data/repo/note_repo.dart';
import 'package:wordie/src/features/home/domain/note.dart';

final firebaseDbRefProvider = Provider((ref) => FirebaseDatabase.instance);

final firebaseDbInstance = Provider((ref) => FirebaseDatabase.instance);
final notesListProvider = StreamNotifierProvider<NotesListNotifier, List<Note>>(
  () => NotesListNotifier(),
);

final selectedNoteProvider = StateProvider((ref) =>
    Note(title: '', body: '', created: '', updated: '', isFavorite: false));
final notesRepoProvider = Provider((ref) => NoteRepo(ref: ref));

final asyncAddNoteProvider =
    AsyncNotifierProvider<AsyncCreateNoteNotifier, bool>(
  () => AsyncCreateNoteNotifier(),
);

class NotesListNotifier extends StreamNotifier<List<Note>> {
  @override
  Stream<List<Note>> build() {
    return getNotesStream(ref.watch(currentUserProvider).value!.userId);
  }

  Stream<List<Note>> getNotesStream(String userId) {
    return ref.read(notesRepoProvider).getNotesStream(userId);
  }
}

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
    required String oldTitle,
    required String newTitle,
    required String newBody,
  }) async {
    bool success = false;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      success = await ref.read(notesRepoProvider).updateNote(
          userId: userId,
          oldTitle: oldTitle,
          newTitle: newTitle,
          newBody: newBody);
      return success;
    });
    if (state.hasError) {
      state = AsyncValue.error(state.error!, state.stackTrace!);

      log(state.stackTrace!.toString());
    }
    return success;
  }
}

final asyncDeleteNoteProvider =
    AsyncNotifierProvider<AsyncDeleteNoteNotifier, bool>(
  () => AsyncDeleteNoteNotifier(),
);

class AsyncDeleteNoteNotifier extends AsyncNotifier<bool> {
  @override
  FutureOr<bool> build() {
    throw UnimplementedError();
  }

  Future<bool> deleteNote({
    required String userId,
    required String oldTitle,
  }) async {
    bool success = false;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      success = await ref.read(notesRepoProvider).deleteNote(
            userId: userId,
            oldTitle: oldTitle,
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

class AsyncCreateNoteNotifier extends AsyncNotifier<bool> {
  @override
  FutureOr<bool> build() {
    throw UnimplementedError();
  }

  Future<bool> createNote(
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
