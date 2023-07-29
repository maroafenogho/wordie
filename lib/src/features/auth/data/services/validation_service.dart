import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/extensions/extensions.dart';

class ValidationService {
  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email cannot be empty';
    } else {
      if (!email.isValidEmail()) {
        return 'Please enter a valid email address';
      }
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password cannot be empty';
    } else {
      if (!password.containsNumber()) {
        return 'Your password must contain a number';
      }
      if (!password.containsUppercase()) {
        return 'Your password must contain an uppercase character';
      }
      if (!password.has8OrMoreCharacters()) {
        return 'Your password must be at least 8 characters long';
      }
    }
    return null;
  }
}

final validationServiceProvider = Provider.autoDispose(
  (ref) => ValidationService(),
);
