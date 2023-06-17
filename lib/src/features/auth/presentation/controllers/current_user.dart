import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/auth/domain/user.dart';
import 'package:wordie/src/features/auth/presentation/controllers/auth_controller.dart';

final currentUserProvider =
    StreamNotifierProvider<UserNotifier, User?>(() => UserNotifier());

class UserNotifier extends StreamNotifier<User?> {
  @override
  Stream<User?> build() {
    return getCurrentUser();
  }

  Stream<User?> getCurrentUser() {
    return ref.read(authRepoProvider).currentUser;
  }
}
