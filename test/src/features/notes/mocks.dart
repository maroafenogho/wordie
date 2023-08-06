import 'package:firebase_database/firebase_database.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordie/src/features/auth/domain/entity/user.dart';
import 'package:wordie/src/features/notes/data/datasources/remote/notes_service.dart';
import 'package:wordie/src/features/notes/domain/user_note.dart';

class MockNotesService extends Mock implements NotesService {
  final MockFirebaseDatabase mockFirebaseDatabase;

  MockNotesService(this.mockFirebaseDatabase);
}

class MockFirebaseDatabase extends Mock implements FirebaseDatabase {}

class MockAppUser extends Mock implements WordieUser {
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
