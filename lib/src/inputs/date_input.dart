import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

/// Email valdiation errors
enum DateValidationError {
  /// Date is empty
  empty,

  /// Date is invalid, not match with date pattern.
  invalid,
}

/// Email representation class which extends [FormzInput] and provides
/// validation logic.
class DateInput extends FormzInput<String, DateValidationError> {
  /// Pure representation of [DateInput]
  const DateInput.pure({String value = ''}) : super.pure(value);

  /// [DateInput] has been modified with [value]
  const DateInput.dirty({String value = ''}) : super.dirty(value);

  /// Convert [DateInput] to pure
  DateInput get toPure => DateInput.pure(value: value);

  /// Convert to [DateTime]
  DateTime get toDateTime => _dateFormat.parse(value);

  @override
  DateValidationError? validator(String? value) {
    if (value == null) {
      return DateValidationError.empty;
    }

    if (value.isEmpty) {
      return DateValidationError.empty;
    }
    try {
      _dateFormat.parse(value);
    } catch (e) {
      return DateValidationError.invalid;
    }

    return null;
  }

  static final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
}
