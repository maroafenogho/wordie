import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/game/data/services/note_service.dart';

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
        ref: ref, userId: userId, noteTitle: noteTitle, noteBody: noteBody);
  }
}
