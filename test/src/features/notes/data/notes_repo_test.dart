import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordie/src/features/notes/domain/user_note.dart';

import '../mocks.dart';

void main() {
  late MockNotesService notesRepository;
  final mockDb = MockFirebaseDatabase();
  final mockUser = MockAppUser();

  setUp(() {
    notesRepository = MockNotesService(mockDb);
  });
  group('notes:', () {
    test('add new note', () async {
      when(() => notesRepository.createNote(
          userId: mockUser.userId,
          noteTitle: 'noteTitle',
          noteBody: 'Body')).thenAnswer((_) => Future.value(true));

      final success = await notesRepository.createNote(
          userId: mockUser.userId, noteTitle: 'noteTitle', noteBody: 'Body');

      verify(
        () => notesRepository.createNote(
            userId: mockUser.userId, noteTitle: 'noteTitle', noteBody: 'Body'),
      ).called(1);

      expect(true, success);
    });
    test('get notes', () {
      when(() => notesRepository.getNotesStream(mockUser.userId))
          .thenAnswer((_) => Stream.value(<Note>[]));
    });
  });
}
