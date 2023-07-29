import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/auth/data/services/validation_service.dart';

class ValidationRepository {
  ValidationRepository(this._validationService);
  final ValidationService _validationService;

  String? validateEmail(String? email) {
    return _validationService.validateEmail(email);
  }

  String? validatePassword(String? password) {
    return _validationService.validatePassword(password);
  }
}

final validationRepositoryProvider =
    Provider.autoDispose((ref) => ValidationRepository(ref.watch(validationServiceProvider)));
