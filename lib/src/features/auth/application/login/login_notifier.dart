import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/auth/data/repo/validation_repo.dart';

class EmailValidationNotifier extends AutoDisposeNotifier<String?> {
  @override
  String? build() {
    return null;
  }

  String? validateEmail(String? email) {
    return ref
        .watch(validationRepo.select((value) => value.validateEmail(email)));
  }
}

final emailValidationProvider =
    AutoDisposeNotifierProvider<EmailValidationNotifier, String?>(
        () => EmailValidationNotifier());

class PasswordValidationNotifier extends AutoDisposeNotifier<String?> {
  @override
  String? build() {
    return null;
  }

  String? validateEmail(String? password) {
    return ref
        .watch(validationRepo.select((value) => value.validateEmail(password)));
  }
}

final passwordValidationProvider =
    AutoDisposeNotifierProvider<PasswordValidationNotifier, String?>(
        () => PasswordValidationNotifier());
