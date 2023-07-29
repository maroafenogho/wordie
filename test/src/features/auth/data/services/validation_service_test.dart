import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  final mockValidationService = MockValidationService();

  group('Email validation tests:', () {
    test('email validation for empty email', () {
      when(() => mockValidationService.validateEmail(''))
          .thenReturn('Email cannot be empty');

      final response = mockValidationService.validateEmail('');
      expect(response, 'Email cannot be empty');
    });
    test('email validation for malformed email', () {
      when(() => mockValidationService.validateEmail('maro'))
          .thenReturn('Please enter a valid email address');

      final response = mockValidationService.validateEmail('maro');
      expect(response, 'Please enter a valid email address');
    });
    test('email validation for good email', () {
      when(() => mockValidationService.validateEmail('maro@gmail.com'))
          .thenReturn(null);
      final response = mockValidationService.validateEmail('maro@gmail.com');
      expect(response, null);
    });
  });
  group('Password validation tests:', () {
    test('empty password', () {
      when(
        () => mockValidationService.validatePassword(''),
      ).thenReturn('Password cannot be empty');

      final response = mockValidationService.validatePassword('');
      expect(response, 'Password cannot be empty');
    });
    test('password without uppercase', () {
      when(
        () => mockValidationService.validatePassword('rtwt435653'),
      ).thenReturn('Your password must contain an uppercase character');

      final response = mockValidationService.validatePassword('rtwt435653');
      expect(response, 'Your password must contain an uppercase character');
    });
    test('password without number', () {
      when(
        () => mockValidationService.validatePassword('qwertyQhhhj'),
      ).thenReturn('Your password must contain a number');

      final response = mockValidationService.validatePassword('qwertyQhhhj');
      expect(response, 'Your password must contain a number');
    });
    test('password with less than 8 characters', () {
      when(
        () => mockValidationService.validatePassword('Qw35Ty'),
      ).thenReturn('Your password must be at least 8 characters long');

      final response = mockValidationService.validatePassword('Qw35Ty');
      expect(response, 'Your password must be at least 8 characters long');
    });
    test('password following correct format', () {
      when(
        () => mockValidationService.validatePassword('QWErTy34'),
      ).thenReturn(null);
      final response = mockValidationService.validatePassword('QWErTy34');
      expect(response, null);
    });
  });
}
