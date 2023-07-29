import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/auth/data/repo/validation_repository.dart';

class ValidationNotifier extends AutoDisposeNotifier<String?> {
  @override
  String? build() {
    return null;
  }

  String? validateEmail(String? email) {
    return ref.watch(validationRepositoryProvider
        .select((value) => value.validateEmail(email)));
  }

  String? validatePassword(String? password) {
    return ref.watch(validationRepositoryProvider
        .select((value) => value.validatePassword(password)));
  }
}

final validationNotifierProvider =
    AutoDisposeNotifierProvider<ValidationNotifier, String?>(
        () => ValidationNotifier());
