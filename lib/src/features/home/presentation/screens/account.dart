import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/common/constants.dart';
import 'package:wordie/src/features/auth/presentation/controllers/auth_controller.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    return Scaffold(
      backgroundColor: WordieConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: WordieConstants.backgroundColor,
        leading: Container(),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () async {
                await ref.read(asyncLogoutProvider.notifier).logout();
              },
              child: Text('Logout'))
        ],
      ),
    );
  }
}
