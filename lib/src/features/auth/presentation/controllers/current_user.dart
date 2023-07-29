import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/auth/data/repo/auth_repo.dart';
import 'package:wordie/src/features/auth/domain/user.dart';

final currentUserProvider =
    StreamNotifierProvider<UserNotifier, AppUser?>(() => UserNotifier());

class UserNotifier extends StreamNotifier<AppUser?> {
  @override
  Stream<AppUser?> build() {
    return getCurrentUser();
  }

  Stream<AppUser?> getCurrentUser() {
    return ref.watch(authRepoProvider).currentUser;
  }
}
