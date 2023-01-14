// ignore_for_file: prefer_const_constructors

import 'package:formz_representation/formz_representation.dart';
import 'package:test/test.dart';

void main() {
  group('EmailInput', () {
    test('can be instantiated', () {
      expect(EmailInput.pure(), isNotNull);
    });

    test('pure is true when super.pure is used', () {
      expect(EmailInput.pure().pure, isTrue);
    });

    test('pure is false when super.dirty is used', () {
      expect(EmailInput.dirty().pure, isFalse);
    });

    test('displayError is null when super.pure is used', () {
      expect(EmailInput.pure().displayError, isNull);
    });

    test('displayError is null when super.pure is used with an initial value',
        () {
      expect(EmailInput.pure(value: 'luis').displayError, isNull);
    });

    test('displayError is not null when super.dirty is used', () {
      expect(EmailInput.dirty().displayError, isNotNull);
    });

    test(
        'displayError is [EmailValidationError.empty] when super.dirty is used',
        () {
      expect(EmailInput.dirty().displayError, EmailValidationError.empty);
    });

    test('displayError is [EmailValidationError.invalid]', () {
      expect(
        EmailInput.dirty(value: 'lesp').displayError,
        EmailValidationError.invalid,
      );
    });

    test('displayError is null if super.dirty value is valid', () {
      expect(
        EmailInput.dirty(value: 'lesp@gmail.com').displayError,
        isNull,
      );
    });

    test('displayError is null if super.dirty.toPure is used', () {
      expect(
        EmailInput.dirty(value: 'lesp').toPure.displayError,
        isNull,
      );
    });
  });

  group('PasswordInput', () {
    test('can be instantiated', () {
      expect(PasswordInput.pure(), isNotNull);
    });

    test('pure is true when super.pure is used', () {
      expect(PasswordInput.pure().pure, isTrue);
    });

    test('pure is false when super.dirty is used', () {
      expect(PasswordInput.dirty().pure, isFalse);
    });

    test('displayError is null when super.pure is used', () {
      expect(PasswordInput.pure().displayError, isNull);
    });

    test('displayError is null when super.pure is used with an initial value',
        () {
      expect(PasswordInput.pure(value: 'luis').displayError, isNull);
    });

    test('displayError is not null when super.dirty is used', () {
      expect(PasswordInput.dirty().displayError, isNotNull);
    });

    test('PasswordValidationError is not empty', () {
      expect(PasswordInput.dirty().displayError, PasswordValidationError.empty);
    });

    test('PasswordValidationError is less than 8 characters', () {
      expect(
        PasswordInput.dirty(value: '1234567').displayError,
        PasswordValidationError.invalidCharactersNumber,
      );
    });
    test('PasswordValidationError is not contains lowercase', () {
      expect(
        PasswordInput.dirty(value: 'ABCDEFG1').displayError,
        PasswordValidationError.notContainsLowercase,
      );
    });

    test('PasswordValidationError is not contains uppercase', () {
      expect(
        PasswordInput.dirty(value: 'abcdefg1').displayError,
        PasswordValidationError.notContainsUppercase,
      );
    });

    test('PasswordValidationError is not contains digits', () {
      expect(
        PasswordInput.dirty(value: 'ABCdefg.').displayError,
        PasswordValidationError.notContainsDigits,
      );
    });

    test('PasswordValidationError is not contains special characters', () {
      expect(
        PasswordInput.dirty(value: 'ABCdef12').displayError,
        PasswordValidationError.notContainsSpecialCharacters,
      );
    });
  });
}
