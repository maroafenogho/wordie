import 'package:flutter_test/flutter_test.dart';
import 'package:wordie/src/features/notes/domain/user_note.dart';

void main() {
  group('toMap', () {
    test('note with all properties', () {
      const note = Note(
          title: 'Note test',
          body: 'This is a test note',
          created: '2023-07-14 13:02:36.580163',
          noteId: '1689336156580',
          updated: '2023-07-14 13:02:36.580163',
          isFavorite: false);

      expect(note.toMap(), {
        'title': 'Note test',
        'body': 'This is a test note',
        'created': '2023-07-14 13:02:36.580163',
        'updated': '2023-07-14 13:02:36.580163',
        'note_id': '1689336156580',
        'is_favorite': false,
      });
    });

    test('note with title missing', () {
      const note = Note(
          title: '',
          body: 'This is a test note',
          created: '2023-07-14 13:02:36.580163',
          noteId: '1689336156580',
          updated: '2023-07-14 13:02:36.580163',
          isFavorite: false);

      expect(note.toMap(), {
        'title': 'This is a...',
        'body': 'This is a test note',
        'created': '2023-07-14 13:02:36.580163',
        'updated': '2023-07-14 13:02:36.580163',
        'note_id': '1689336156580',
        'is_favorite': false,
      });
    });
  });

  group('fromMap', () {
    test('get Note from map', () {
      final note = Note.fromMap(const {
        'title': 'Note test',
        'body': 'This is a test note',
        'created': '2023-07-14 13:02:36.580163',
        'note_id': '1689336156580',
        'updated': '2023-07-14 13:02:36.580163',
        'is_favorite': false,
      });
      const receivedNote = Note(
          title: 'Note test',
          body: 'This is a test note',
          created: '2023-07-14 13:02:36.580163',
          noteId: '1689336156580',
          updated: '2023-07-14 13:02:36.580163',
          isFavorite: false);
      expect(
        note,
        receivedNote,
      );
    });
  });
}
