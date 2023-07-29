import 'package:flutter/material.dart';
import 'package:wordie/src/common/constants.dart';
import 'package:wordie/src/features/auth/presentation/screens/widgets/wordie_base_form_field.dart';

class EmailFormField extends StatefulWidget {
  const EmailFormField({
    Key? key,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.validator, this.autoValidateMode,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hintText;

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final AutovalidateMode? autoValidateMode;

  final Function(String?)? onChanged;

  @override
  State<EmailFormField> createState() => _EmailFormFieldState();
}

class _EmailFormFieldState extends State<EmailFormField> {
  @override
  Widget build(BuildContext context) {
    return WordieFormInput(
      controller: widget.controller,
      validator: widget.validator,
      hintText: widget.hintText ?? 'Email',
      autoValidateMode: widget.autoValidateMode,
      keyboardType: TextInputType.emailAddress,
      prefix: const Icon(
        Icons.email_outlined,
        color: WordieConstants.mainColor,
      ),
    );
  }
}
