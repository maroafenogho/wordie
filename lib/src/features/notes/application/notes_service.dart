import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/notes/data/notes_repo.dart';

import '../domain/user_note.dart';

class UserNotesService {
  UserNotesService({required this.notesRepository});

  final NotesRepository notesRepository;

  Stream<List<Note>> getNotesList(String userId) {
    return notesRepository.getNotesStream(userId);
  }

  Stream<List<Note>> favNotesList(String userId) {
    return getNotesList(userId)
        .map((event) => event.where((element) => element.isFavorite).toList());
  }
}

final noteServiceProvider = Provider((ref) =>
    UserNotesService(notesRepository: ref.watch(notesRepositoryProvider)));
