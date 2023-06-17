import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/auth/presentation/controllers/current_user.dart';
import 'package:wordie/src/features/home/domain/note.dart';
import 'package:wordie/src/features/home/presentation/controllers/notes_controller.dart';

final notesListProvider = StreamNotifierProvider<NotesListNotifier, List<Note>>(
  () => NotesListNotifier(),
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
