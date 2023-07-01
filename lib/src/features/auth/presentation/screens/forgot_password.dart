// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordie/src/common/app_widgets/wordie_elevated_button.dart';
import 'package:wordie/src/common/constants.dart';
import 'package:wordie/src/common/typography.dart';
import 'package:wordie/src/extensions/extensions.dart';
import 'package:wordie/src/features/auth/presentation/controllers/forgot_password_controller.dart';
import 'package:wordie/src/features/auth/presentation/screens/signup_screen.dart';
import 'package:wordie/src/features/auth/presentation/screens/widgets/formfield.dart';
import 'package:wordie/src/utils/utils.dart';

class ResetPasswordScreen extends ConsumerWidget {
  ResetPasswordScreen({super.key});

  static const routeName = 'reset_password';

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: WordieConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: WordieConstants.backgroundColor,
        leading: InkWell(
          onTap: () {
            context.pop();
          },
          child: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            50.0.vSpace,
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Forgot Password',
                textAlign: TextAlign.start,
                style: WordieTypography.h4,
              ),
            ),
            20.0.vSpace,
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Enter your email address below to receive a password reset code',
                textAlign: TextAlign.start,
                style: WordieTypography.bodyText12,
              ),
            ),
            10.0.vSpace,
            WordieFormInput(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              hintText: 'Email',
              prefixIcon: const Icon(
                Icons.email_outlined,
                color: WordieConstants.mainColor,
              ),
            ),
            30.0.vSpace,
            WordieButton(
              text: 'reset',
              isLoading: ref.watch(asyncResetPasswordProvider).isLoading,
              onPressed: () async {
                if (emailController.text.isNotEmpty) {
                  final success = await ref
                      .watch(asyncResetPasswordProvider.notifier)
                      .resetPassword(
                        emailController.text.trim(),
                      );

                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Password reset email sent!\nPlease check your email for instructions.',
                        style: WordieTypography.bodyText14,
                      ),
                      dismissDirection: DismissDirection.up,
                      backgroundColor: WordieConstants.containerColor,
                    ));
                    context.pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        ref.watch(asyncResetPasswordProvider).error.toString(),
                        style: WordieTypography.bodyText14,
                      ),
                      dismissDirection: DismissDirection.up,
                      backgroundColor: WordieConstants.containerColor,
                    ));
                  }
                } else {
                  showSnackbar('Please fill email text field', context);
                }
              },
            ),
            30.0.vSpace,
            Text.rich(TextSpan(
                text: 'Don\'t have an account? ',
                style: WordieTypography.bodyText12,
                children: [
                  TextSpan(
                      text: 'Sign up',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => context.goNamed(SignUpScreen.routeName),
                      style: WordieTypography.h6.copyWith(
                          color: const Color.fromARGB(255, 48, 167, 251)))
                ])),
          ],
        ),
      ),
    ).darkStatusBar();
  }
}
