import 'package:firebase_database/firebase_database.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordie/src/features/auth/data/repo/auth_repo.dart';
import 'package:wordie/src/features/auth/domain/user.dart';
import 'package:wordie/src/features/notes/data/notes_repo.dart';

class MockNotesRepository extends Mock implements NotesRepository {}

class MockFirebaseDatabase extends Mock implements FirebaseDatabase {}

class MockAppUser extends Mock implements User {}

class MockAuthRepository extends Mock implements AuthRepo {}
