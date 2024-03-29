import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/auth/presentation/controllers/current_user.dart';

import '../../data/repositories/notes_repository.dart';
import '../../domain/user_note.dart';

class AsyncFavNotesNotifier extends AutoDisposeStreamNotifier<List<Note>> {
  @override
  Stream<List<Note>> build() {
    return getFavNotesStream();
  }

  Stream<List<Note>> getFavNotesStream() {
    final user = ref.watch(currentUserProvider).value;

    if (user == null) {
      throw AssertionError('User cannot be null');
    }

    return ref.watch(notesrepositoryProvider).favNotesList(user.userId);
  }
}

final asyncFavNotesStream =
    AutoDisposeStreamNotifierProvider<AsyncFavNotesNotifier, List<Note>>(
  () => AsyncFavNotesNotifier(),
);
