import 'package:flutter/material.dart';

class WordieConstants {
  //Colors
  static const mainColor = Color.fromARGB(255, 54, 54, 54);
  static const containerColor = Color.fromARGB(87, 54, 54, 54);
  static const backgroundColor = Color.fromARGB(255, 233, 230, 230);
  static const wordieBlack = Color.fromARGB(255, 18, 18, 18);

  //border styles
  static final outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        color: WordieConstants.mainColor,
        width: 1.5,
      ));
}
