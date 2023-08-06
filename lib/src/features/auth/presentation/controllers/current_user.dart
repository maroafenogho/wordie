import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/auth/domain/entity/user.dart';
import 'package:wordie/src/features/auth/domain/usecases/usecases.dart';

final currentUserProvider =
    StreamNotifierProvider<UserNotifier, WordieUser?>(() => UserNotifier());

class UserNotifier extends StreamNotifier<WordieUser?> {
  @override
  Stream<WordieUser?> build() {
    return getCurrentUser();
  }

  Stream<WordieUser?> getCurrentUser() {
    return ref.watch(authUsecaseProvider).executeGetUser();
  }
}
