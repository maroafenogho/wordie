import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/auth/presentation/controllers/current_user.dart';

import '../../application/notes_service.dart';
import '../../domain/user_note.dart';

class AsyncNotesNotifier extends AutoDisposeStreamNotifier<List<Note>> {
  @override
  Stream<List<Note>> build() {
    return getNotesStream();
  }

  Stream<List<Note>> getNotesStream() {
    final user = ref.watch(currentUserProvider).value;

    if (user == null) {
      log('No User');
      throw AssertionError('User cannot be null');
    }
    log('Getting notes');
    return ref.watch(noteServiceProvider).getNotesList(user.userId);
  }
}

final asyncNotesStream =
    AutoDisposeStreamNotifierProvider<AsyncNotesNotifier, List<Note>>(
  () => AsyncNotesNotifier(),
);
