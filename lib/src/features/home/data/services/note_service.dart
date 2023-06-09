import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/home/domain/note.dart';
import 'package:wordie/src/features/home/presentation/controllers/notes_controller.dart';

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
        'is_favorite': true,
        'created': DateTime.now().toString(),
        'updated': DateTime.now().toString()
      });
      success = true;
    } catch (e) {
      success = false;
    }
    return success;
  }

  Future<bool> setDbRef({
    required Ref ref,
    required String userId,
  }) async {
    bool success = false;
    final dbRef = ref.watch(firebaseDbInstance).ref('notes/$userId/notes');
    try {
      await dbRef.set({});
      success = true;
    } catch (e) {
      success = false;
    }
    return success;
  }

  List<Note> _listFromFirebase(DatabaseEvent event) {
    final list = <Note>[];
    if (event.snapshot.value != null) {
      Map<dynamic, dynamic> map = event.snapshot.value as Map;

      map.forEach((key, value) {
        log(value.toString());
        list.add(Note.fromMap(value));
      });
    }

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

  Future<bool> updateNote(
      {required String userId,
      required String oldTitle,
      required String newTitle,
      required String newBody,
      required Ref ref}) async {
    bool success = false;
    final dbRef =
        ref.watch(firebaseDbInstance).ref('notes/$userId/notes/$oldTitle');
    try {
      await dbRef.update({
        'title': newTitle,
        'body': newBody,
        'updated': DateTime.now().toString()
      });
      success = true;
    } catch (error) {
      print(error);
    }
    return success;
  }

  Future<bool> updateFavNote(
      {required String userId,
      required String oldTitle,
      required bool isFav,
      required Ref ref}) async {
    bool success = false;
    final dbRef =
        ref.watch(firebaseDbInstance).ref('notes/$userId/notes/$oldTitle');
    try {
      await dbRef
          .update({'is_favorite': isFav, 'updated': DateTime.now().toString()});
      success = true;
    } catch (error) {
      print(error);
    }
    return success;
  }

  Future<bool> deleteNote(
      {required String userId,
      required String oldTitle,
      required Ref ref}) async {
    bool success = false;
    final dbRef =
        ref.watch(firebaseDbInstance).ref('notes/$userId/notes/$oldTitle');
    try {
      await dbRef.remove();
      success = true;
    } catch (error) {
      print(error);
    }
    return success;
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
