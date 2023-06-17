import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

///{@template countryX}
/// [CountryModel] enherit class with [Equatable]
/// provides validation logic.
/// {@endtemplate}
class CountryModel implements Equatable {
  /// {@macro countryX}
  const CountryModel({
    required this.name,
    required this.flag,
    required this.code,
    required this.dialCode,
    required this.minLength,
    required this.maxLength,
  });

  /// Country name
  final String name;

  /// Country flag emoji
  final String flag;

  /// Country two letters code
  final String code;

  /// Country phone code
  final String dialCode;

  /// Country min length for phone number
  final int minLength;

  /// Country max length for phone number
  final int maxLength;

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

  /// Phone number character lenght is less than [CountryModel.minLength] or
  /// more than [CountryModel.maxLength]
  invalidLength,
}

/// Phone representation class which extends [FormzInput] and provides
/// validation logic.
class PhoneInput extends FormzInput<String, PhoneValidationError> {
  /// Pure representation of [PhoneInput]
  const PhoneInput.pure({
    String value = '',
    this.country,
  }) : super.pure(
          value,
        );

  /// Dirty [PhoneInput]
  const PhoneInput.dirty({
    String value = '',
    this.country,
  }) : super.dirty(value);

  /// Country
  final CountryModel? country;

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

    if (value.length < country!.minLength ||
        value.length > country!.maxLength) {
      return PhoneValidationError.invalidLength;
    }

    return null;
  }

  /// Convert [PhoneInput] to pure
  PhoneInput get toPure => PhoneInput.pure(value: value);
}
