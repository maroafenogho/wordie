import 'package:equatable/equatable.dart';
import 'package:wordie/src/extensions/extensions.dart';

class Note extends Equatable {
  final String title;
  final String body;
  final String created;
  final String updated;
  final String noteId;
  final bool isFavorite;

  const Note(
      {required this.title,
      required this.body,
      required this.created,
      required this.noteId,
      required this.updated,
      required this.isFavorite});

  factory Note.fromMap(Map<dynamic, dynamic> map) {
    return Note(
        title: map['title'],
        body: map['body'],
        created: map['created'],
        noteId: map['note_id'] ?? '',
        isFavorite: map['is_favorite'] ?? false,
        updated: map['updated']);
  }
  Map<String, dynamic> toMap() => {
        'title': title.isEmpty ? body.extractTitle : title,
        'body': body,
        'created': created,
        'updated': updated,
        'note_id': noteId,
        'is_favorite': isFavorite,
      };

  @override
  List<Object?> get props =>
      [title, body, created, noteId, updated, isFavorite];
}
