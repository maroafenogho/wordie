import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/user_note.dart';

class NotesService {
  NotesService(this._firebaseDbRef);

  final FirebaseDatabase _firebaseDbRef;

  String userNotesEntry(String userId) => 'notes/$userId/notes';

  Future<bool> createNote(
      {required String userId,
      String? category,
      required String noteTitle,
      required String noteBody}) async {
    bool success = false;
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    final note = Note(
        title: noteTitle,
        body: noteBody,
        created: DateTime.now().toString(),
        noteId: id,
        updated: DateTime.now().toString(),
        isFavorite: false);
    final dbRef = _firebaseDbRef.ref(userNotesEntry(userId));
    try {
      await dbRef.child(id).set(note.toMap());
      success = true;
    } catch (e) {
      success = false;
      log(e.toString());
      throw Exception(e.toString());
    }
    return success;
  }

  // Future<bool> addCategory({
  //   required Ref ref,
  //   required String userId,
  //   String? category,
  // }) async {
  //   bool success = false;
  //   final dbRef = ref.watch(firebaseDbInstance).ref('notes/$userId/categories');
  //   try {
  //     await dbRef.child(category).set
  //   }
  //   try {
  //     success = true;
  //   } catch (e) {
  //     success = false;
  //   }
  //   return success;
  // }

  List<Note> _listFromFirebase(DatabaseEvent event) {
    final list = <Note>[];
    if (event.snapshot.value != null) {
      Map<dynamic, dynamic> map = event.snapshot.value as Map;

      map.forEach((key, value) {
        list.add(Note.fromMap(value));
      });
    }
    return list;
  }

  Stream<List<Note>> getNotesStream(String userId) {
    final dbRef = _firebaseDbRef.ref(userNotesEntry(userId));
    return dbRef.onValue.map(_listFromFirebase);
  }

  Future<bool> updateNote(
      {required String userId,
      required String noteId,
      required String newTitle,
      required String newBody}) async {
    bool success = false;
    final dbRef = _firebaseDbRef.ref('${userNotesEntry(userId)}/$noteId');
    try {
      await dbRef.update({
        'title': newTitle,
        'body': newBody,
        'updated': DateTime.now().toString()
      });
      success = true;
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
    return success;
  }

  Future<bool> updateFavNote(
      {required String userId,
      required String noteId,
      required bool isFav}) async {
    bool success = false;
    final dbRef = _firebaseDbRef.ref('${userNotesEntry(userId)}/$noteId');
    try {
      await dbRef.update({'is_favorite': isFav});
      success = true;
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
    return success;
  }

  Future<bool> deleteNote(
      {required String userId, required String noteId}) async {
    bool success = false;
    final dbRef = _firebaseDbRef.ref('${userNotesEntry(userId)}/$noteId');
    try {
      await dbRef.remove();
      success = true;
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
    return success;
  }
}

final firebaseDbProvider = Provider((ref) => FirebaseDatabase.instance);

final notesServiceProvider =
    Provider((ref) => NotesService(ref.watch(firebaseDbProvider)));
