import 'package:formz/formz.dart';

/// [UrlInput] validation error
enum UrlValidationError {
  /// Email is empty
  empty,

  /// Email is invalid, not match with email pattern.
  invalid,
}

/// Url representation class which extends [FormzInput] and provides
/// validation logic.
class UrlInput extends FormzInput<String, UrlValidationError> {
  /// Pure representation of [UrlInput]
  const UrlInput.pure({String value = ''}) : super.pure(value);

  /// Dirty representation of [UrlInput]
  const UrlInput.dirty({String value = ''}) : super.dirty(value);

  /// Display error if the [UrlInput] is not valid
  /// and has been modified
  @override
  UrlValidationError? get displayError => isPure ? null : error;

  /// Convert [UrlInput] to pure
  UrlInput get toPure => UrlInput.pure(value: value);

  @override
  UrlValidationError? validator(String value) {
    if (value.isEmpty) {
      return UrlValidationError.empty;
    }
    if (!RegExp(_urlPattern).hasMatch(value)) {
      return UrlValidationError.invalid;
    }

    return null;
  }

  static const String _urlPattern =
      r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
}
