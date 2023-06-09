// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordie/src/common/app_widgets/wordie_elevated_button.dart';
import 'package:wordie/src/common/constants.dart';
import 'package:wordie/src/common/typography.dart';
import 'package:wordie/src/extensions/word_extensions.dart';
import 'package:wordie/src/features/auth/presentation/controllers/auth_controller.dart';
import 'package:wordie/src/features/auth/presentation/screens/signup_screen.dart';
import 'package:wordie/src/features/auth/presentation/screens/widgets/formfield.dart';
import 'package:wordie/src/features/home/presentation/screens/home.dart';
import 'package:wordie/src/utils/utils.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  static const routeName = '/login_screen';

  final emailController = TextEditingController();
  final nameController = TextEditingController();
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
                style: WordieTypography.bodyText14,
                children: [
                  TextSpan(text: 'WORDIE', style: WordieTypography.h1)
                ])),
            10.0.vSpace,
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Login',
                textAlign: TextAlign.start,
                style: WordieTypography.h4,
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
            10.0.vSpace,
            WordieFormInput(
              controller: passwordController,
              obscureText: !ref.watch(showPasswordProvider),
              hintText: 'Password',
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
            30.0.vSpace,
            WordieButton(
              text: 'LOGIN',
              isLoading: ref.watch(asyncLoginProvider).isLoading,
              onPressed: () async {
                if (emailController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty) {
                  final user =
                      await ref.watch(asyncLoginProvider.notifier).login(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );

                  if (user == null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text(ref.watch(asyncLoginProvider).error.toString(),style: WordieTypography.bodyText14,),
                      dismissDirection: DismissDirection.up,
                      backgroundColor: WordieConstants.containerColor,
                    ));
                  } else {
                    if (user.emailVerified) {
                       showSnackbar(
                       'Login successful',
                        context);
                     
                      context.go(HomeScreen.routeName);
                    } else {}
                  }
                } else {
                  showSnackbar(
                        'Please fill all text fields',
                        context);
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
    ).lightStatusBar();
  }
}
