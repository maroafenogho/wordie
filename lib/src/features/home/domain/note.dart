class Note {
  String title;
  String body;
  String created;
  String updated;
  bool isFavorite;

  Note(
      {required this.title,
      required this.body,
      required this.created,
      required this.updated,
      required this.isFavorite});

  factory Note.fromMap(Map<dynamic, dynamic> map) {
    return Note(
        title: map['title'],
        body: map['body'],
        created: map['created'],
        isFavorite: map['is_favorite'] ?? false,
        updated: map['updated']);
  }
}