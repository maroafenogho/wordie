import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordie/src/features/auth/domain/user.dart';
import 'package:wordie/src/features/notes/data/notes_repo.dart';
import 'package:wordie/src/features/notes/domain/user_note.dart';

import '../mocks.dart';

void main() {
  late NotesRepository notesRepository;
  final testUser = User(
      email: 'maroafenogho+test1@gmail.com',
      emailVerified: true,
      userId: 'Gvcudrefc');

  setUp(() {
    notesRepository = MockNotesRepository();
  });
  group('notes', () {
    test('add note', () async {
      when(() => notesRepository.createNote(
          userId: testUser.userId,
          noteTitle: 'noteTitle',
          noteBody: 'Body')).thenAnswer((_) => Future.value(true));
      final success = await notesRepository.createNote(
          userId: testUser.userId, noteTitle: 'noteTitle', noteBody: 'Body');
      verify(
        () => notesRepository.createNote(
            userId: testUser.userId, noteTitle: 'noteTitle', noteBody: 'Body'),
      ).called(1);

      expect(true, success);
    });

    test('get notes', () {
      when(() => notesRepository.getNotesStream(testUser.userId))
          .thenAnswer((_) => Stream.value(<Note>[]));

      notesRepository.getNotesStream(testUser.userId);

      verify(() => notesRepository.getNotesStream(testUser.userId)).called(1);
    });
  });
}
