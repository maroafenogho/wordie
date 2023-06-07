// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordie/src/common/constants.dart';
import 'package:wordie/src/common/typography.dart';
import 'package:wordie/src/extensions/word_extensions.dart';
import 'package:wordie/src/features/auth/presentation/controllers/auth_controller.dart';
import 'package:wordie/src/features/auth/presentation/screens/login_screen.dart';
import 'package:wordie/src/features/auth/presentation/screens/widgets/formfield.dart';

class SignUpScreen extends ConsumerWidget {
  SignUpScreen({super.key});

  static const routeName = '/signup_screen';

  final emailController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: WordieConstants.backgroundColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            50.0.vSpace,
            const Text.rich(TextSpan(
                text: 'Welcome to ',
                style: WordieTypography.bodyTextStyle2,
                children: [
                  TextSpan(text: 'WORDIE', style: WordieTypography.h1)
                ])),
            10.0.vSpace,
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Fill in your details below to create an account.',
                textAlign: TextAlign.start,
                style: WordieTypography.bodyTextStyle1,
              ),
            ),
            10.0.vSpace,
            WordieFormInput(
              controller: emailController,
              hintText: 'Email',
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(
                Icons.email_outlined,
                color: WordieConstants.mainColor,
              ),
            ),
            10.0.vSpace,
            WordieFormInput(
              controller: passwordController,
              hintText: 'Password',
              obscureText: !ref.watch(showPasswordProvider),
              suffixIcon: InkWell(
                onTap: () {
                  ref.read(showPasswordProvider.notifier).state =
                      !ref.watch(showPasswordProvider);
                },
                child: Icon(
                    ref.watch(showPasswordProvider)
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: WordieConstants.mainColor),
              ),
              prefixIcon: const Icon(
                Icons.lock_outline,
                color: WordieConstants.mainColor,
              ),
            ),
            10.0.vSpace,
            WordieFormInput(
              controller: firstnameController,
              hintText: 'First name',
              keyboardType: TextInputType.name,
              prefixIcon: const Icon(
                Icons.account_circle_outlined,
                color: WordieConstants.mainColor,
              ),
            ),
            10.0.vSpace,
            WordieFormInput(
              controller: lastnameController,
              hintText: 'Last name',
              keyboardType: TextInputType.name,
              prefixIcon: const Icon(
                Icons.account_circle_outlined,
                color: WordieConstants.mainColor,
              ),
            ),
            30.0.vSpace,
            SizedBox(
              height: 55,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () async {
                  if (emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty &&
                      firstnameController.text.isNotEmpty &&
                      lastnameController.text.isNotEmpty) {
                    final user = await ref
                        .watch(asyncSignUpProvider.notifier)
                        .signUp(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            firstName: firstnameController.text.trim(),
                            lastName: lastnameController.text.trim());

                    if (user == null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            ref.watch(asyncSignUpProvider).error.toString()),
                        dismissDirection: DismissDirection.up,
                        backgroundColor: WordieConstants.mainColor,
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'User registration successful. Please check your email to verify your account'),
                        dismissDirection: DismissDirection.up,
                        backgroundColor: WordieConstants.mainColor,
                      ));
                      context.go(LoginScreen.routeName);
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please fill all text fields'),
                      dismissDirection: DismissDirection.up,
                      backgroundColor: WordieConstants.mainColor,
                    ));
                  }
                },
                style: ElevatedButton.styleFrom(
                    foregroundColor: WordieConstants.backgroundColor,
                    backgroundColor: WordieConstants.mainColor),
                child: ref.watch(asyncSignUpProvider).isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Sign Up'),
              ),
            ),
            30.0.vSpace,
            Text.rich(TextSpan(
                text: 'Already have an account? ',
                style: WordieTypography.bodyTextStyle1,
                children: [
                  TextSpan(
                      text: 'Sign in',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => context.goNamed(LoginScreen.routeName),
                      style: WordieTypography.h6.copyWith(
                          color: const Color.fromARGB(255, 48, 167, 251)))
                ])),
          ],
        ),
      ),
    ).lightStatusBar();
  }
}
