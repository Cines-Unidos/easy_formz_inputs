# easy_formz_inputs

The easy_formz_inputs library provides pre-built, validated input fields for use in Dart and Flutter applications. Inputs currently provided include email, password, confirm password, URL, date, phone, and non-empty fields.

## Installation

To use the easy_formz_inputs library, add the corresponding dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  easy_formz_inputs: ^0.1.1
```

Then, import the library in your code:

```dart
import 'package:easy_formz_inputs/easy_formz_inputs.dart';
```

## Usage

The easy_formz_inputs library provides pre-built and validated input fields. Each input field is defined as a form field, which can be used to validate and manage user input data.

### EmailInput

The `EmailInput` is a form field that validates email addresses entered by the user. To use it, simply create an instance of the `EmailInput` class:

```dart
final email = EmailInput.dirty();
```
Then you can use the `email` form field in your form:

```dart
TextField(
  decoration: InputDecoration(labelText: 'Email'),
  onChanged: (value) {
    email.value = value;
  },
  keyboardType: TextInputType.emailAddress,
),
```

### PasswordInput

The `PasswordInput` is a form field that validates the length and complexity of passwords entered by the user. To use it, simply create an instance of the `PasswordInput` class:

```dart
final password = PasswordInput.dirty();
```
Then you can use the `password` form field in your form:

```dart
TextField(
  decoration: InputDecoration(labelText: 'Password'),
  onChanged: (value) {
    password.value = value;
  },
  obscureText: true,
),
```

### ConfirmPasswordInput

The `ConfirmPasswordInput` is a form field that compares two password fields to ensure that they match. To use it, simply create an instance of the `ConfirmPasswordInput` class and pass the original password field as an argument:

```dart
final confirmPassword = ConfirmPasswordInput.dirty(password: password, value: '');
```

Then you can use the `confirmPassword` form field in your form:
```dart
TextField(
  decoration: InputDecoration(labelText: 'Confirm password'),
  onChanged: (value) {
    confirmPassword.value = value;
  },
  obscureText: true,
),
```

### UrlInput

The `UrlInput` is a form field that validates URLs entered by the user. To use it, simply create an instance of the `UrlInput` class:
```dart
final url = UrlInput.dirty();
```
Then you can use the `url` form field in your form:
```dart
TextField(
  decoration: InputDecoration(labelText: 'URL'),
  onChanged: (value) {
    url.value = value;
  },
  keyboardType: TextInputType.url,
),
```

### NonEmptyInput

The `NonEmptyInput` is a form field that validates that the user has entered a non-empty value. To use it, simply create an instance of the `NonEmptyInput` class:

```dart
final nonEmpty = NonEmptyInput.dirty();
```

Then you can use the `nonEmpty` form field in your form:

```dart
TextField(
  decoration: InputDecoration(labelText: 'Non-empty field'),
  onChanged: (value) {
    nonEmpty.value = value;
  },
),
```

### DateInput

The `DateInput` is a form field that validates  that the user entered a date value, with the format 'DD/MM/YYYY'.

```dart
final dateInput = DateInput.dirty(value: '09/03/2022');
```

Then you can use the `dateInput` form field in your form:
```dart
TextField(
  decoration: InputDecoration(labelText: 'Birthdate'),
  onChanged: (value) {
    dateInput.value = value;
  },
),
```

### PhoneInput

The `PhoneInput` is a form field that validates  that the user entered a date value, with the format 'DD/MM/YYYY'.

```dart
final phoneInput = PhoneInput.dirty(value: '12312312',
  country: CountryModel(
      name: 'Venezuela, Bolivarian Republic of Venezuela',
      flag: '🇻🇪',
      code: 'VE',
      dialCode: '58',
      minLength: 10,
      maxLength: 10,
    )
);
```

Then you can use the `phoneInput` form field in your form:
```dart
TextField(
  decoration: InputDecoration(labelText: 'Phone'),
  onChanged: (value) {
    phoneInput.value = value;
  },
),
```