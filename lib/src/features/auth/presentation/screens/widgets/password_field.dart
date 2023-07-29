import 'package:flutter/material.dart';
import 'package:wordie/src/common/constants.dart';
import 'package:wordie/src/features/auth/presentation/screens/widgets/wordie_base_form_field.dart';

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({
    Key? key,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.validator,
    this.autoValidateMode,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hintText;
  final AutovalidateMode? autoValidateMode;

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  final Function(String?)? onChanged;

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return WordieFormInput(
      controller: widget.controller,
      validator: widget.validator,
      hintText: widget.hintText ?? 'Password',
      obscureText: obscurePassword,
      autoValidateMode: widget.autoValidateMode,
      keyboardType: TextInputType.emailAddress,
      prefix: const Icon(
        Icons.lock_outline,
        color: WordieConstants.mainColor,
      ),
      suffix: InkWell(
        onTap: () {
          setState(() {
            obscurePassword = !obscurePassword;
          });
        },
        child: Icon(obscurePassword ? Icons.visibility : Icons.visibility_off,
            color: WordieConstants.mainColor),
      ),
    );
  }
}
