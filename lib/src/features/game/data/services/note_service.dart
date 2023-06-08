import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/game/presentation/controllers/notes_controller.dart';

class NoteService {
  Future<bool> createNote(
      {required Ref ref,
      required String userId,
      required String noteTitle,
      required String noteBody}) async {
    bool success = false;
    final dbRef = ref.watch(firebaseDbInstance).ref('notes/$userId/notes');
    try {
      await dbRef.child(noteTitle).set({
        'title': noteTitle,
        'body': noteBody,
        'created': DateTime.now().toString(),
        'updated': DateTime.now().toString()
      });
      success = true;
    } catch (e) {
      print(e);
      success = false;
    }
    return success;
  }
}
