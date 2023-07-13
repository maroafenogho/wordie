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

  Future<bool> createNote(
      {required String userId,
      required String noteTitle,
      required String noteBody}) async {
    return notesRepository.createNote(
      userId: userId,
      noteTitle: noteTitle,
      noteBody: noteBody,
    );
  }

  Future<bool> updateNote(
      {required String userId,
      required String noteId,
      required String newTitle,
      required String newBody}) async {
    return notesRepository.updateNote(
      userId: userId,
      newTitle: newTitle,
      newBody: newBody,
      noteId: noteId,
    );
  }

  Future<bool> updateFavNote(
      {required String userId,
      required String noteId,
      required bool isFav}) async {
    return notesRepository.updateFavNote(
      userId: userId,
      noteId: noteId,
      isFav: isFav,
    );
  }
}

final noteServiceProvider = Provider((ref) =>
    UserNotesService(notesRepository: ref.watch(notesRepositoryProvider)));
