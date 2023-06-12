import 'package:formz/formz.dart';

/// [ConfirmPasswordInput] validation error
enum ConfirmPasswordValidationError {
  /// ConfirmPassword is empty
  empty,

  /// ConfirmPassword no coincidence
  noCoincidence
}

/// Password representation class which extends [FormzInput] and provides
/// validation logic.
class ConfirmPasswordInput
    extends FormzInput<String, ConfirmPasswordValidationError> {
  /// Pure representation of [ConfirmPasswordInput]
  const ConfirmPasswordInput.pure({
    String value = '',
    this.password = '',
  }) : super.pure(value);

  /// Dirty representation of [ConfirmPasswordInput]
  const ConfirmPasswordInput.dirty({
    String value = '',
    required this.password,
  }) : super.dirty(value);

  /// Password value to confirm
  final String password;

  /// Display error if the [ConfirmPasswordInput] is not valid
  /// and has been modified
  @override
  ConfirmPasswordValidationError? get displayError => isPure ? null : error;

  /// Convert [ConfirmPasswordInput] to pure
  ConfirmPasswordInput get toPure =>
      ConfirmPasswordInput.pure(value: value, password: password);

  @override
  ConfirmPasswordValidationError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return ConfirmPasswordValidationError.empty;
    }

    if (value != password) {
      return ConfirmPasswordValidationError.noCoincidence;
    }

    return null;
  }
}
