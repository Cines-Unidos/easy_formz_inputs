// ignore_for_file: prefer_const_constructors

import 'package:formz_representation/formz_representation.dart';
import 'package:test/test.dart';

void main() {
  group('EmailInput', () {
    test('can be instantiated', () {
      expect(EmailInput.pure(), isNotNull);
    });

    test('pure is true when super.pure is used', () {
      expect(EmailInput.pure().isPure, isTrue);
    });

    test('pure is false when super.dirty is used', () {
      expect(EmailInput.dirty().isPure, isFalse);
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
      expect(PasswordInput.pure().isPure, isTrue);
    });

    test('pure is false when super.dirty is used', () {
      expect(PasswordInput.dirty().isPure, isFalse);
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

    test('displayError is null if super.dirty.toPure is used', () {
      expect(
        PasswordInput.dirty().toPure.displayError,
        isNull,
      );
    });

    test('password errorList contains all password validation errors', () {
      expect(
        PasswordInput.dirty().errorList,
        containsAll(
          [
            PasswordValidationError.empty,
            PasswordValidationError.notContainsDigits,
            PasswordValidationError.invalidCharactersNumber,
            PasswordValidationError.notContainsLowercase,
            PasswordValidationError.notContainsUppercase,
            PasswordValidationError.notContainsSpecialCharacters,
          ],
        ),
      );
    });
    test('password errorList with a lowercase letter value', () {
      expect(
        PasswordInput.dirty(value: 'a').errorList,
        containsAll(
          [
            PasswordValidationError.notContainsDigits,
            PasswordValidationError.invalidCharactersNumber,
            PasswordValidationError.notContainsUppercase,
            PasswordValidationError.notContainsSpecialCharacters,
          ],
        ),
      );
    });

    test('password errorList with a lowercase letter value', () {
      expect(
        PasswordInput.dirty(value: 'A').errorList,
        containsAll(
          [
            PasswordValidationError.notContainsDigits,
            PasswordValidationError.invalidCharactersNumber,
            PasswordValidationError.notContainsLowercase,
            PasswordValidationError.notContainsSpecialCharacters,
          ],
        ),
      );
    });

    test('password errorList with lowercase and uppercase letters', () {
      expect(
        PasswordInput.dirty(value: 'Aa').errorList,
        containsAll(
          [
            PasswordValidationError.notContainsDigits,
            PasswordValidationError.invalidCharactersNumber,
            PasswordValidationError.notContainsSpecialCharacters,
          ],
        ),
      );
    });

    test('password errorList with lowercase and uppercase letters', () {
      expect(
        PasswordInput.dirty(value: 'Aa').errorList,
        containsAll(
          [
            PasswordValidationError.notContainsDigits,
            PasswordValidationError.invalidCharactersNumber,
            PasswordValidationError.notContainsSpecialCharacters,
          ],
        ),
      );
    });

    test('password errorList with lowercase, uppercase and digit', () {
      expect(
        PasswordInput.dirty(value: 'Aa1').errorList,
        containsAll(
          [
            PasswordValidationError.invalidCharactersNumber,
            PasswordValidationError.notContainsSpecialCharacters,
          ],
        ),
      );
    });

    test('password errorList with lowercase, uppercase, digit, special char',
        () {
      expect(
        PasswordInput.dirty(value: 'Aa1.').errorList,
        containsAll(
          [
            PasswordValidationError.invalidCharactersNumber,
          ],
        ),
      );
    });

    test('password errorList is empty', () {
      expect(
        PasswordInput.dirty(value: 'Aa1.Aa1.Aa1.').errorList,
        isEmpty,
      );
    });

    test('password errorList is not empty', () {
      expect(
        PasswordInput.pure().errorList,
        isNotEmpty,
      );
    });
  });

  group('ConfirmPasswordInput', () {
    test('can be instantiated', () {
      expect(ConfirmPasswordInput.pure(), isNotNull);
    });

    test('pure is true when super.pure is used', () {
      expect(ConfirmPasswordInput.pure().isPure, isTrue);
    });

    test('pure is false when super.dirty is used', () {
      expect(ConfirmPasswordInput.dirty(password: '').isPure, isFalse);
    });

    test('displayError is null when super.pure is used', () {
      expect(ConfirmPasswordInput.pure().displayError, isNull);
    });

    test('displayError is null when super.pure is used with an initial value',
        () {
      expect(ConfirmPasswordInput.pure(value: 'pass').displayError, isNull);
    });

    test('displayError is not null when super.dirty is used', () {
      expect(ConfirmPasswordInput.dirty(password: '').displayError, isNotNull);
    });

    test(
        'displayError is [EmailValidationError.empty] when super.dirty is used',
        () {
      expect(
        ConfirmPasswordInput.dirty(password: '').displayError,
        ConfirmPasswordValidationError.empty,
      );
    });

    test('displayError is [EmailValidationError.invalid]', () {
      expect(
        ConfirmPasswordInput.dirty(value: 'luis', password: 'siul')
            .displayError,
        ConfirmPasswordValidationError.noCoincidence,
      );
    });

    test('displayError is null if super.dirty value is valid', () {
      expect(
        ConfirmPasswordInput.dirty(value: 'password', password: 'password')
            .displayError,
        isNull,
      );
    });

    test('displayError is null if super.dirty.toPure is used', () {
      expect(
        ConfirmPasswordInput.dirty(value: 'password', password: '')
            .toPure
            .displayError,
        isNull,
      );
    });
  });

  group('NonEmptyInput', () {
    test('can be instantiated', () {
      expect(NonEmptyInput.pure(), isNotNull);
    });

    test('pure is true when super.pure is used', () {
      expect(NonEmptyInput.pure().isPure, isTrue);
    });

    test('pure is false when super.dirty is used', () {
      expect(NonEmptyInput.dirty().isPure, isFalse);
    });

    test('displayError is null when super.pure is used', () {
      expect(NonEmptyInput.pure().displayError, isNull);
    });

    test('displayError is null when super.pure is used with an initial value',
        () {
      expect(NonEmptyInput.pure(value: 'luis').displayError, isNull);
    });

    test('displayError is not null when super.dirty is used', () {
      expect(NonEmptyInput.dirty().displayError, isNotNull);
    });

    test('NonEmptyValidationError is not empty', () {
      expect(NonEmptyInput.dirty().displayError, NonEmptyValidationError.empty);
    });

    test('NonEmptyValidationError is empty', () {
      expect(
        NonEmptyInput.dirty().displayError,
        NonEmptyValidationError.empty,
      );
    });

    test('NonEmptyValidationError is null', () {
      expect(
        NonEmptyInput.dirty(value: 'hola').displayError,
        isNull,
      );
    });

    test('NonEmptyValidationError is notNull when pure().toDirty', () {
      expect(
        NonEmptyInput.pure(value: 'luis').toDirty.displayError,
        isNull,
      );
    });

    test('NonEmptyValidationError is null when .toPure', () {
      expect(
        NonEmptyInput.dirty().toPure.displayError,
        isNull,
      );
    });
  });

  group('UrlInput', () {
    test('can be instantiated', () {
      expect(UrlInput.pure(), isNotNull);
    });

    test('pure is true when super.pure is used', () {
      expect(UrlInput.pure().isPure, isTrue);
    });

    test('pure is false when super.dirty is used', () {
      expect(UrlInput.dirty().isPure, isFalse);
    });

    test('displayError is null when super.pure is used', () {
      expect(UrlInput.pure().displayError, isNull);
    });

    test('displayError is null when super.pure is used with an initial value',
        () {
      expect(UrlInput.pure(value: 'luis').displayError, isNull);
    });

    test('displayError is not null when super.dirty is used', () {
      expect(UrlInput.dirty().displayError, isNotNull);
    });

    test('UrlValidationError is not empty', () {
      expect(UrlInput.dirty().displayError, UrlValidationError.empty);
    });

    test('UrlValidationError is empty', () {
      expect(
        UrlInput.dirty().displayError,
        UrlValidationError.empty,
      );
    });

    test('UrlValidationError is not valid', () {
      expect(
        UrlInput.dirty(value: 'luis').displayError,
        UrlValidationError.invalid,
      );
    });

    test('UrlValidationError is null when .toPure', () {
      expect(
        UrlInput.dirty(value: 'luis').toPure.displayError,
        isNull,
      );
    });

    test('UrlValidationError is empty', () {
      expect(
        UrlInput.dirty().displayError,
        UrlValidationError.empty,
      );
    });

    test('UrlValidationError is null', () {
      expect(
        UrlInput.dirty(value: 'http://test.com').displayError,
        isNull,
      );
    });
  });

  group('PhoneInput', () {
    final countryExample = CountryModel(
      name: 'Venezuela, Bolivarian Republic of Venezuela',
      flag: '🇻🇪',
      code: 'VE',
      dialCode: '58',
      minLength: 10,
      maxLength: 10,
    );
    test('can be instantiated', () {
      expect(PhoneInput.pure(), isNotNull);
    });

    test('pure is true when super.pure is used', () {
      expect(PhoneInput.pure().isPure, isTrue);
    });

    test('pure is false when super.dirty is used', () {
      expect(PhoneInput.dirty().isPure, isFalse);
    });

    test('displayError is null when super.pure is used', () {
      expect(PhoneInput.pure().displayError, isNull);
    });

    test('displayError is null when super.pure is used with an initial value',
        () {
      expect(PhoneInput.pure(value: '123123').displayError, isNull);
    });

    test('displayError is not null when super.dirty is used', () {
      expect(PhoneInput.dirty().displayError, isNotNull);
    });

    test('PhoneValidationError is not empty', () {
      expect(PhoneInput.dirty().displayError, PhoneValidationError.empty);
    });

    test('PhoneValidationError is empty', () {
      expect(
        PhoneInput.dirty().displayError,
        PhoneValidationError.empty,
      );
    });

    test('PhoneValidationError is noCountrySelected', () {
      expect(
        PhoneInput.dirty(value: '4149137341').displayError,
        PhoneValidationError.noCountrySelected,
      );
    });

    test('PhoneValidationError is invalidLength (less then min len)', () {
      expect(
        PhoneInput.dirty(
          value: '414913',
          country: countryExample,
        ).displayError,
        PhoneValidationError.invalidLength,
      );
    });

    test('PhoneValidationError is invalidLength (more then max len)', () {
      expect(
        PhoneInput.dirty(
          value: '41491313121231',
          country: countryExample,
        ).displayError,
        PhoneValidationError.invalidLength,
      );
    });

    test('PhoneValidationError is null when .toPure', () {
      expect(
        PhoneInput.dirty(value: '414123').toPure.displayError,
        isNull,
      );
    });

    test('PhoneValidationError is null', () {
      expect(
        PhoneInput.dirty(
          value: '4149137341',
          country: countryExample,
        ).displayError,
        isNull,
      );
    });

    test('PhoneInput.fullPhone match', () {
      expect(
        PhoneInput.dirty(
          value: '4149137341',
          country: countryExample,
        ).fullPhone,
        '+${countryExample.dialCode}4149137341',
      );
    });

    test('CountryModel props', () {
      expect(
        countryExample.props,
        [
          countryExample.name,
          countryExample.flag,
          countryExample.code,
          countryExample.dialCode,
          countryExample.minLength,
          countryExample.maxLength
        ],
      );
    });

    test('CountryModel stringify', () {
      expect(
        countryExample.stringify,
        true,
      );
    });
  });
}
