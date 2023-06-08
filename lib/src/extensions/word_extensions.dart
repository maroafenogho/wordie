import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension WordLength on String {
  int get wordLength => length;
}

extension Shuffle on String {
  List<String> get shuffledWord {
    List<String> word = split('');
    word.shuffle();
    return word;
  }
}

extension MyRadius on double {
  Radius get cRadius {
    return Radius.circular(this);
  }
}

extension SizeB on double {
  SizedBox get vSpace => SizedBox(
        height: this,
      );
  SizedBox get hSpace => SizedBox(
        width: this,
      );
}

extension Annotation on Widget {
  AnnotatedRegion<SystemUiOverlayStyle> darkStatusBar() =>
      AnnotatedRegion(value: SystemUiOverlayStyle.dark, child: this);
  AnnotatedRegion<SystemUiOverlayStyle> lightStatusBar() =>
      AnnotatedRegion(value: SystemUiOverlayStyle.light, child: this);
}
