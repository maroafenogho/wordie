import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/auth/presentation/controllers/auth_controller.dart';
import 'package:wordie/src/features/auth/presentation/screens/login_screen.dart';
import 'package:wordie/src/features/game/presentation/screens/home.dart';

class Wrapper extends ConsumerWidget {
  static const routeName = '/auth_wrapper';
  const Wrapper({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    return currentUser.when(
      data: (user) {
        return user == null ? LoginScreen() : HomeScreen();
      },
      loading: () => CircularProgressIndicator(),
      error: (error, stackTrace) => LoginScreen(),
    );
  }
}
