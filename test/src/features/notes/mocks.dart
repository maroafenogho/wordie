import 'package:firebase_database/firebase_database.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordie/src/features/auth/data/repo/auth_repo.dart';
import 'package:wordie/src/features/auth/domain/user.dart';
import 'package:wordie/src/features/notes/data/notes_repo.dart';
import 'package:wordie/src/features/notes/domain/user_note.dart';

class MockNotesRepository extends Mock implements NotesRepository {
  final MockFirebaseDatabase mockFirebaseDatabase;

  MockNotesRepository(this.mockFirebaseDatabase);
}

class MockFirebaseDatabase extends Mock implements FirebaseDatabase {}

class MockAppUser extends Mock implements User {
  @override
  bool get emailVerified => true;

  @override
  set email(String email) {
    'maro@gmai.com';
  }

  @override
  String get email => 'maro@gmail.com';

  @override
  String get userId => 'Grtej6u4y78nvsdnjk';
}

class MockNote extends Mock implements Note {
  @override
  String get title => 'title';
}

class MockAuthRepository extends Mock implements AuthRepo {}
