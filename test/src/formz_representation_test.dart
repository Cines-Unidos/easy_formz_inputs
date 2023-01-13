// ignore_for_file: prefer_const_constructors

import 'package:formz_representation/src/inputs/email.dart';
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
  });
}
