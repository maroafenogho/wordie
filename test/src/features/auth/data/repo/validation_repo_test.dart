import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  final mockValidationRepo = MockValidationRepo();

  group('Email validation tests:', () {
    test('email validation for empty email', () {
      when(() => mockValidationRepo.validateEmail(''))
          .thenReturn('Email cannot be empty');

      final response = mockValidationRepo.validateEmail('');
      expect(response, 'Email cannot be empty');
    });
    test('email validation for malformed email', () {
      when(() => mockValidationRepo.validateEmail('maro'))
          .thenReturn('Please enter a valid email address');

      final response = mockValidationRepo.validateEmail('maro');
      expect(response, 'Please enter a valid email address');
    });
    test('email validation for good email', () {
      when(() => mockValidationRepo.validateEmail('maro@gmail.com'))
          .thenReturn(null);
      final response = mockValidationRepo.validateEmail('maro@gmail.com');
      expect(response, null);
    });
  });
  group('Password validation tests:', () {
    test('empty password', () {
      when(
        () => mockValidationRepo.validatePassword(''),
      ).thenReturn('Password cannot be empty');

      final response = mockValidationRepo.validatePassword('');
      expect(response, 'Password cannot be empty');
    });
    test('password without uppercase', () {
      when(
        () => mockValidationRepo.validatePassword('rtwt435653'),
      ).thenReturn('Your password must contain an uppercase character');

      final response = mockValidationRepo.validatePassword('rtwt435653');
      expect(response, 'Your password must contain an uppercase character');
    });
    test('password without number', () {
      when(
        () => mockValidationRepo.validatePassword('qwertyQhhhj'),
      ).thenReturn('Your password must contain a number');

      final response = mockValidationRepo.validatePassword('qwertyQhhhj');
      expect(response, 'Your password must contain a number');
    });
    test('password with less than 8 characters', () {
      when(
        () => mockValidationRepo.validatePassword('Qw35Ty'),
      ).thenReturn('Your password must be at least 8 characters long');

      final response = mockValidationRepo.validatePassword('Qw35Ty');
      expect(response, 'Your password must be at least 8 characters long');
    });
    test('password following correct format', () {
      when(
        () => mockValidationRepo.validatePassword('QWErTy34'),
      ).thenReturn(null);
      final response = mockValidationRepo.validatePassword('QWErTy34');
      expect(response, null);
    });
  });
}
