import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:intl_phone_field/countries.dart';

///{@template countryX}
/// [Country] enherit class with [Equatable]
/// provides validation logic.
/// {@endtemplate}
class CountryX extends Country implements Equatable {
  /// {@macro countryX}
  const CountryX({
    required super.name,
    required super.flag,
    required super.code,
    required super.dialCode,
    required super.minLength,
    required super.maxLength,
  });

  /// Create [CountryX] from [Country]
  factory CountryX.fromCountry(Country country) {
    return CountryX(
      name: country.name,
      flag: country.flag,
      code: country.code,
      dialCode: country.dialCode,
      minLength: country.minLength,
      maxLength: country.maxLength,
    );
  }

  @override
  List<Object?> get props => [name, flag, code, dialCode, minLength, maxLength];

  @override
  bool? get stringify => false;
}

/// [PhoneInput] errors
enum PhoneValidationError {
  /// Phone number is empty
  empty,

  /// Phone number not match with phone regex
  invalid,

  /// Phone not have a country selected
  noCountrySelected,

  /// Phone number character lenght is less than [Country.minLength] or
  /// more than [Country.maxLength]
  invalidLength,
}

/// Phone representation class which extends [FormzInput] and provides
/// validation logic.
class PhoneInput extends FormzInput<String, PhoneValidationError> {
  /// Pure representation of [PhoneInput]
  const PhoneInput.pure({
    String number = '',
    this.country,
  }) : super.pure(
          number,
        );

  /// Dirty [PhoneInput]
  const PhoneInput.dirty({
    String number = '',
    required this.country,
  }) : super.dirty(number);

  /// Country
  final CountryX? country;

  /// Display [PhoneValidationError] error if [isPure]
  @override
  PhoneValidationError? get displayError => isPure ? null : error;

  /// Get full phone text dialCode + phoneNumber (includes + at beginning)
  String get fullPhone => '+${country?.dialCode ?? ''}$value';

  @override
  PhoneValidationError? validator(String? value) {
    // if (pure) return null;
    if (value == null) {
      return PhoneValidationError.empty;
    }

    if (value.isEmpty) {
      return PhoneValidationError.empty;
    }

    if (country == null) {
      return PhoneValidationError.noCountrySelected;
    }

    // if (!RegExp(_phonePattern).hasMatch(value)) {
    //   return PhoneValidationError.invalid;
    // }

    if (value.length < country!.minLength ||
        value.length > country!.maxLength) {
      return PhoneValidationError.invalidLength;
    }

    return null;
  }

  /// Convert [PhoneInput] to pure
  PhoneInput get toPure => PhoneInput.pure(number: value);

  // static const String _phonePattern =
  //     r'\+?\d{1,4}?[-.\s]?\(?\d{1,3}?\)?[-.\s]?\d{1,4}[-.\s]?\d{1,4}[-.\s]?\d{1,9}';
}
