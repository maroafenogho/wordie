import 'package:flutter_test/flutter_test.dart';
import 'package:wordie/src/features/auth/data/repo/validation_repo.dart';

void main() {
  final repo = ValidationRepo();

  group('Email validation tests:', () {
    test('email validation for empty email', () {
      final emailVal = repo.validateEmail('');
      expect(emailVal, 'Email cannot be empty');
    });
    test('email validation for malformed email', () {
      final emailVal = repo.validateEmail('maro');
      expect(emailVal, 'Please enter a valid email address');
    });
    test('email validation for good email', () {
      final emailVal = repo.validateEmail('maro@gmail.com');
      expect(emailVal, null);
    });
  });
  group('Password validation tests:', () {
    test('empty password', () {
      final passwordVal = repo.validatePassword('');
      expect(passwordVal, 'Password cannot be empty');
    });
    test('password without uppercase', () {
      final passwordVal = repo.validatePassword('qwertty2232');
      expect(passwordVal, 'Your password must contain an uppercase character');
    });
    test('password without number', () {
      final passwordVal = repo.validatePassword('qwertyQ');
      expect(passwordVal, 'Your password must contain a number');
    });
    test('password with less than 8 characters', () {
      final passwordVal = repo.validatePassword('Qwt5j');
      expect(passwordVal, 'Your password must be at least 8 characters long');
    });
    test('password following correct format', () {
      final passwordVal = repo.validatePassword('Qwt5j');
      expect(passwordVal, 'Your password must be at least 8 characters long');
    });
  });
}
