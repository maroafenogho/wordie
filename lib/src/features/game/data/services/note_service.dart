import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/game/domain/note.dart';
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
      success = false;
    }
    return success;
  }

  List<Note> _listFromFirebase(DatabaseEvent event) {
    final list = <Note>[];
    Map<dynamic, dynamic> map = event.snapshot.value as Map;
    map.forEach((key, value) {
      log(value.toString());
      list.add(Note.fromMap(value));
    });
    return list;
  }

  Stream<List<Note>> getNotesStream(String userId, Ref ref) {
    final dbRef = ref.watch(firebaseDbInstance).ref('notes/$userId/notes');
    return dbRef.onValue.map(_listFromFirebase);
    // dbRef.onValue.listen((event) {
    //   Map<dynamic, dynamic> map = event.snapshot.value as Map;
    //   map.forEach((key, value) {
    //     log(value.toString());
    //     list.add(Note.fromMap(value));
    //   });
    // });
  }

  Future<List<Note>> getNotes(String userId, Ref ref) async {
    final list = <Note>[];
    final dbRef = ref.watch(firebaseDbInstance).ref('notes/$userId/notes');
    dbRef.onValue.listen((event) => event.snapshot.value!);
    final snapshot = await dbRef.once();
    // Map values = snapshot.snapshot.value!;
    await dbRef.once().then((value) {
      Map<dynamic, dynamic> map = value.snapshot.value as Map;
      map.forEach((key, value) {
        log(value.toString());
        list.add(Note.fromMap(value));
      });
      // for (final note in value.snapshot.value) {
      //   list.add(Note.fromMap(note));
      // }
      value.snapshot.value;
    });
    print(snapshot.snapshot.value);
    // for (final note in snapshot.snapshot.children) {
    //   list.add(Note.fromMap(note.));
    // }
    return list;
  }
}
