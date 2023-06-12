import 'package:formz/formz.dart';

/// NonEmtpy Errors
enum NonEmptyValidationError {
  /// Empty value error
  empty,
}

///{@template non_empty_field}
/// Non-empty field representation class which extends [FormzInput] and
/// provides validation logic.
/// {@endtemplate}
class NonEmptyInput extends FormzInput<String, NonEmptyValidationError> {
  /// {@macro non_empty_field}
  ///
  /// Creates a new instance of [NonEmptyInput] with empty value.
  const NonEmptyInput.pure({String value = ''}) : super.pure(value);

  /// {@macro non_empty_field}
  ///
  /// Creates a new instance of [NonEmptyInput] with the given `value`.
  const NonEmptyInput.dirty({String value = ''}) : super.dirty(value);

  /// Display error if [isPure]
  @override
  NonEmptyValidationError? get displayError => isPure ? null : error;

  @override
  NonEmptyValidationError? validator(String value) {
    if (value.isEmpty) {
      return NonEmptyValidationError.empty;
    }
    return null;
  }

  /// Convert [NonEmptyInput] to pure
  NonEmptyInput get toPure => NonEmptyInput.pure(value: value);

  /// Convert [NonEmptyInput] to dirty
  NonEmptyInput get toDirty => NonEmptyInput.dirty(value: value);
}
