import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wordie/src/common/constants.dart';
import 'package:wordie/src/features/home/domain/note.dart';

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

extension PadLeft on int {
  String get padLeft {
    return toString().padLeft(2, '0');
  }
}

extension Date on String {
  String get dateFromString {
    final date = DateTime.parse(this);
    return '${date.hour.remainder(24).padLeft}:${date.minute.remainder(60).padLeft} ${date.day.remainder(31).padLeft}-${date.month.remainder(12).padLeft}-${date.year}';
  }
}

extension IntDate on String {
  int get epochDateFromString {
    final date = DateTime.parse(this).millisecondsSinceEpoch;
    return date;
  }
}

extension MyList on List<Note> {
  List<Note> get orderedByDate {
    sort(((a, b) => b.created.epochDateFromString
        .compareTo(a.created.epochDateFromString)));
    return this;
  }
}

extension Greeting on DateTime {
  String get greeting {
    if (hour > 16) {
      return '🌆 Good evening,';
    } else if (hour > 11) {
      return '🌞 Good afternoon,';
    } else if (hour > 4) {
      return '🌄 Good morning,';
    } else {
      return '🌄 Good morning,';
    }
  }
}

extension SeparateName on String {
  String get firstName {
    return split(' ')[0];
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
  AnnotatedRegion<SystemUiOverlayStyle> darkStatusBar() => AnnotatedRegion(
      value: SystemUiOverlayStyle.dark
          .copyWith(statusBarColor: WordieConstants.backgroundColor),
      child: this);
  AnnotatedRegion<SystemUiOverlayStyle> lightStatusBar() =>
      AnnotatedRegion(value: SystemUiOverlayStyle.light, child: this);
}
