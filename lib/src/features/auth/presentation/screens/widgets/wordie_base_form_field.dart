import 'package:flutter/material.dart';
import 'package:wordie/src/common/constants.dart';
import 'package:wordie/src/common/typography.dart';

class WordieFormInput extends StatefulWidget {
  const WordieFormInput({
    Key? key,
    this.controller,
    this.obscureText = false,
    this.hintText,
    this.prefix,
    this.suffix,
    this.onChanged,
    this.keyboardType,
    this.validator,
    this.autoValidateMode,
  }) : super(key: key);

  final TextEditingController? controller;
  final bool obscureText;
  final String? hintText;
  final TextInputType? keyboardType;
  final Widget? prefix;
  final Widget? suffix;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final AutovalidateMode? autoValidateMode;

  @override
  State<WordieFormInput> createState() => _WordieFormInputState();
}

class _WordieFormInputState extends State<WordieFormInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: WordieTypography.bodyText14,
      onChanged: widget.onChanged,
      controller: widget.controller,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      autovalidateMode: widget.autoValidateMode,
      decoration: InputDecoration(
        // isDense: true,
        prefixIcon: widget.prefix,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),

        suffixIcon: widget.suffix,
        focusColor: WordieConstants.mainColor,
        fillColor: WordieConstants.backgroundColor,
        hintText: widget.hintText,
        hintStyle: WordieTypography.bodyText14,
        enabledBorder: WordieConstants.outlineBorder,
        focusedBorder: WordieConstants.outlineBorder,
        errorBorder: WordieConstants.errorOutlineBorder,
        focusedErrorBorder: WordieConstants.focusedErrorOutlineBorder,
      ),
      cursorColor: WordieConstants.mainColor,
    );
  }
}
