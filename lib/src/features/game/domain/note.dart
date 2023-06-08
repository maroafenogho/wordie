class Note {
  String title;
  String body;
  String created;
  String updated;

  Note(
      {required this.title,
      required this.body,
      required this.created,
      required this.updated});

  factory Note.fromMap(Map<dynamic, dynamic> map) {
    return Note(
        title: map['title'],
        body: map['body'],
        created: map['created'],
        updated: map['updated']);
  }
}
