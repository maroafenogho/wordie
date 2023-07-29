import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/notes/data/datasources/remote/notes_service.dart';

import '../../domain/user_note.dart';

class NotesRepository {
  NotesRepository({required this.notesService});

  final NotesService notesService;

  Stream<List<Note>> getNotesList(String userId) {
    return notesService.getNotesStream(userId);
  }

  Stream<List<Note>> favNotesList(String userId) {
    return getNotesList(userId)
        .map((event) => event.where((element) => element.isFavorite).toList());
  }

  Future<bool> createNote(
      {required String userId,
      required String noteTitle,
      required String noteBody}) async {
    return notesService.createNote(
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
    return notesService.updateNote(
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
    return notesService.updateFavNote(
      userId: userId,
      noteId: noteId,
      isFav: isFav,
    );
  }
}

final notesrepositoryProvider = Provider(
    (ref) => NotesRepository(notesService: ref.watch(notesServiceProvider)));
