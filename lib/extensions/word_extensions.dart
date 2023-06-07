import 'package:flutter/material.dart';

extension WordLength on String {
  int get wordLength => length;
}

extension Shuffle on String {
  List<String> get shuffledWord {
    List<String> word = split('');
    word.shuffle();
    print(word);
    return word;
  }
}

extension Size on double {
  SizedBox get vSpace => SizedBox(
        height: this,
      );
  SizedBox get hSpace => SizedBox(
        width: this,
      );
}
