class Word {
  String word;
  String hint;
  Word({required this.word, required this.hint});

  factory Word.fromJson(Map<String, dynamic> wordModel) {
    return Word(word: wordModel['word'], hint: wordModel['hint']);
  }
}
