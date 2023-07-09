// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordie/src/common/constants.dart';
import 'package:wordie/src/features/auth/presentation/controllers/logout_controller.dart';
import 'package:wordie/src/features/auth/presentation/screens/login_screen.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final currentUser = ref.watch(currentUserProvider);
    return Scaffold(
      backgroundColor: WordieConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: WordieConstants.backgroundColor,
        leading: Container(),
      ),
      body: Column(
        children: [
          const Center(
            child: Icon(
              Icons.account_circle_sharp,
              size: 75,
            ),
          ),
          TextButton(
              onPressed: () async {
                await ref.watch(asyncLogoutProvider.notifier).logout();
                // if (success) {
                //   context.goNamed(LoginScreen.routeName);
                // }
              },
              child: const Text('Logout'))
        ],
      ),
    );
  }
}
