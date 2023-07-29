import 'package:flutter/material.dart';

class WordieConstants {
  //Colors
  static const mainColor = Color.fromARGB(255, 54, 54, 54);
  static const errorColor = Color.fromARGB(255, 255, 0, 0);
  static const containerColor = Color.fromARGB(255, 208, 208, 208);
  static const backgroundColor = Color.fromARGB(255, 233, 230, 230);
  static const backgroundColor2 = Color.fromARGB(107, 233, 230, 230);
  static const wordieBlack = Color.fromARGB(255, 18, 18, 18);

  //border styles
  static final outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        color: WordieConstants.mainColor,
        width: 1.5,
      ));

  static final enabledOutlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        color: WordieConstants.mainColor,
        width: 1.5,
      ));

  static final focusedOutlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        color: WordieConstants.mainColor,
        width: 1.5,
      ));

  static final errorOutlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        color: WordieConstants.errorColor,
        width: 1.5,
      ));

  static final focusedErrorOutlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        color: WordieConstants.errorColor,
        width: 1.5,
      ));
}
