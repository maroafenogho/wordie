import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/home/data/services/note_service.dart';

import '../../../notes/domain/user_note.dart';
// import 'package:wordie/src/features/home/domain/note.dart';

class NoteRepo {
  final NoteService _noteService;
  final Ref ref;

  NoteRepo({NoteService? service, required this.ref})
      : _noteService = service ?? NoteService();

  Future<bool> createNote(
      {required String userId,
      required String noteTitle,
      required String noteBody}) async {
    return _noteService.createNote(
        ref: ref,
        userId: userId,
        noteTitle: noteTitle,
        noteBody: noteBody,
        noteId: DateTime.now().millisecondsSinceEpoch.toString());
  }

  Stream<List<Note>> getNotesStream(String userId) {
    return _noteService.getNotesStream(userId, ref);
  }

  Future<bool> updateFavNote({
    required String userId,
    required String noteId,
    required bool isFav,
  }) async {
    return _noteService.updateFavNote(
        userId: userId, noteId: noteId, isFav: isFav, ref: ref);
  }

  Future<bool> deleteNote({
    required String userId,
    required String noteId,
  }) async {
    return _noteService.deleteNote(userId: userId, noteId: noteId, ref: ref);
  }

  Future<bool> updateNote({
    required String userId,
    required String noteId,
    required String newTitle,
    required String newBody,
  }) {
    return _noteService.updateNote(
        userId: userId,
        noteId: noteId,
        newTitle: newTitle,
        newBody: newBody,
        ref: ref);
  }
}
