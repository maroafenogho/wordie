import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/home/data/repo/note_repo.dart';
import 'package:wordie/src/features/home/domain/note.dart';

final firebaseDbRefProvider = Provider((ref) => FirebaseDatabase.instance);

final firebaseDbInstance = Provider((ref) => FirebaseDatabase.instance);

final selectedNoteProvider = StateProvider((ref) =>
    Note(title: '', body: '', created: '', updated: '', isFavorite: false));
final notesRepoProvider = Provider((ref) => NoteRepo(ref: ref));
