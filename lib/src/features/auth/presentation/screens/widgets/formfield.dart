import 'package:flutter/material.dart';
import 'package:wordie/src/common/constants.dart';
import 'package:wordie/src/common/typography.dart';

class WordieFormInput extends StatelessWidget {
  const WordieFormInput({
    Key? key,
    required this.controller,
    this.obscureText = false,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.keyboardType,
  }) : super(key: key);

  final TextEditingController controller;
  final bool obscureText;
  final String hintText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: WordieConstants.backgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        style: WordieTypography.bodyText14,
        onChanged: onChanged,
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          // isDense: true,
          prefixIcon: prefixIcon,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),

          suffixIcon: suffixIcon,
          focusColor: WordieConstants.mainColor,
          fillColor: WordieConstants.backgroundColor,
          hintText: hintText,
          hintStyle: WordieTypography.bodyText14,
          enabledBorder: WordieConstants.outlineBorder,
          focusedBorder: WordieConstants.outlineBorder,
        ),
        cursorColor: WordieConstants.mainColor,
      ),
    );
  }
}
