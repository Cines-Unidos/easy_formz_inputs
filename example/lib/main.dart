// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formz/formz.dart';

import 'package:easy_formz_inputs/easy_formz_inputs.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Easy Formz Inputs Example')),
        body: const Padding(
          padding: EdgeInsets.all(24),
          child: SingleChildScrollView(child: MyForm()),
        ),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _key = GlobalKey<FormState>();
  final country = const CountryModel(
    name: 'Venezuela, Bolivarian Republic of Venezuela',
    flag: '🇻🇪',
    code: 'VE',
    dialCode: '58',
    minLength: 10,
    maxLength: 10,
  );
  late MyFormState _state;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final TextEditingController _websiteController;
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _birthdateController;

  void _onEmailChanged() {
    setState(() {
      _state = _state.copyWith(
          email: EmailInput.dirty(value: _emailController.text));
    });
  }

  void _onPasswordChanged() {
    setState(() {
      _state = _state.copyWith(
        password: PasswordInput.dirty(value: _passwordController.text),
      );
    });
  }

  void _onConfirmPasswordChanged() {
    setState(() {
      _state = _state.copyWith(
        confirmPassword: ConfirmPasswordInput.dirty(
            value: _confirmPasswordController.text,
            password: _passwordController.text),
      );
    });
  }

  void _onNameChanged() {
    setState(() {
      _state = _state.copyWith(
          name: NonEmptyInput.dirty(
        value: _nameController.text,
      ));
    });
  }

  void _onBirthdateChanged() {
    setState(() {
      _state = _state.copyWith(
          birthdate: DateInput.dirty(
        value: _birthdateController.text,
      ));
    });
  }

  void _onPhoneChanged() {
    setState(() {
      _state = _state.copyWith(
          phone: PhoneInput.dirty(
        value: _phoneController.text,
        country: country,
      ));
    });
  }

  Future<void> _onSubmit() async {
    if (!_key.currentState!.validate()) return;

    setState(() {
      _state = _state.copyWith(status: FormzSubmissionStatus.inProgress);
    });

    try {
      await _submitForm();
      _state = _state.copyWith(status: FormzSubmissionStatus.success);
    } catch (_) {
      _state = _state.copyWith(status: FormzSubmissionStatus.failure);
    }

    if (!mounted) return;

    setState(() {});

    FocusScope.of(context)
      ..nextFocus()
      ..unfocus();

    const successSnackBar = SnackBar(
      content: Text('Submitted successfully! 🎉'),
    );
    const failureSnackBar = SnackBar(
      content: Text('Something went wrong... 🚨'),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        _state.status.isSuccess ? successSnackBar : failureSnackBar,
      );

    if (_state.status.isSuccess) _resetForm();
  }

  Future<void> _submitForm() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    if (Random().nextInt(2) == 0) throw Exception();
  }

  void _resetForm() {
    _key.currentState!.reset();
    _emailController.clear();
    _passwordController.clear();
    setState(() => _state = MyFormState());
  }

  @override
  void initState() {
    super.initState();
    _state = MyFormState();
    _emailController = TextEditingController(text: _state.email.value)
      ..addListener(_onEmailChanged);
    _passwordController = TextEditingController(text: _state.password.value)
      ..addListener(_onPasswordChanged);
    _confirmPasswordController =
        TextEditingController(text: _state.confirmPassword.value)
          ..addListener(_onConfirmPasswordChanged);
    _websiteController =
        TextEditingController(text: _state.confirmPassword.value)
          ..addListener(_onConfirmPasswordChanged);
    _phoneController = TextEditingController(text: _state.phone.value)
      ..addListener(_onPhoneChanged);
    _birthdateController = TextEditingController(text: _state.birthdate.value)
      ..addListener(_onBirthdateChanged);
    _nameController = TextEditingController(text: _state.name.value)
      ..addListener(_onNameChanged);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    _birthdateController.dispose();
    _phoneController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              helperText: 'Name',
              helperMaxLines: 2,
              labelText: 'Name',
              errorMaxLines: 2,
            ),
            validator: (_) => _state.name.displayError.toString(),
            textInputAction: TextInputAction.done,
          ),
          Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () async {},
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          'assets/flags/${country.code.toLowerCase()}.png',
                          package: 'intl_phone_field',
                          width: 22,
                          height: 22,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 8),
                      FittedBox(
                        child: Text(
                          '+${country.dialCode}',
                          // style: widget.dropdownTextStyle,
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    helperText: 'Phone',
                    helperMaxLines: 2,
                    labelText: 'Phone',
                    errorMaxLines: 2,
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (_) => _state.phone.displayError.toString(),
                  textInputAction: TextInputAction.done,
                ),
              ),
            ],
          ),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              icon: Icon(Icons.email),
              labelText: 'Email',
              helperText: 'A valid email e.g. joe.doe@gmail.com',
            ),
            validator: (_) => _state.email.displayError.toString(),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              icon: Icon(Icons.lock),
              helperText:
                  'At least 8 characters including one letter and number',
              helperMaxLines: 2,
              labelText: 'Password',
              errorMaxLines: 2,
            ),
            validator: (_) => _state.password.displayError.toString(),
            obscureText: true,
            textInputAction: TextInputAction.done,
          ),
          TextFormField(
            controller: _confirmPasswordController,
            decoration: const InputDecoration(
              icon: Icon(Icons.lock),
              helperText: 'Confirm password',
              helperMaxLines: 2,
              labelText: 'Confirm Password',
              errorMaxLines: 2,
            ),
            validator: (_) => _state.confirmPassword.displayError.toString(),
            obscureText: true,
            textInputAction: TextInputAction.done,
          ),
          TextFormField(
            controller: _websiteController,
            decoration: const InputDecoration(
              icon: Icon(Icons.web),
              helperText: 'Website',
              helperMaxLines: 2,
              labelText: 'Website',
              errorMaxLines: 2,
            ),
            validator: (_) => _state.website.displayError.toString(),
            textInputAction: TextInputAction.done,
          ),
          TextFormField(
            controller: _birthdateController,
            decoration: const InputDecoration(
              hintText: 'DD/MM/YYYY',
              icon: Icon(
                Icons.calendar_month,
              ),
            ),
            keyboardType: TextInputType.datetime,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(8),
              DateTextFormatter()
            ],
            validator: (_) => _state.birthdate.displayError.toString(),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 24),
          if (_state.status.isInProgress)
            const CircularProgressIndicator()
          else
            ElevatedButton(
              onPressed: _onSubmit,
              child: const Text('Submit'),
            ),
        ],
      ),
    );
  }
}

class MyFormState with FormzMixin {
  MyFormState({
    this.email = const EmailInput.pure(),
    this.password = const PasswordInput.pure(),
    this.confirmPassword = const ConfirmPasswordInput.pure(),
    this.website = const UrlInput.pure(),
    this.birthdate = const DateInput.pure(),
    this.phone = const PhoneInput.pure(),
    this.name = const NonEmptyInput.pure(),
    this.status = FormzSubmissionStatus.initial,
  });

  final EmailInput email;
  final PasswordInput password;
  final ConfirmPasswordInput confirmPassword;
  final UrlInput website;
  final DateInput birthdate;
  final PhoneInput phone;
  final NonEmptyInput name;
  final FormzSubmissionStatus status;

  MyFormState copyWith({
    EmailInput? email,
    PasswordInput? password,
    ConfirmPasswordInput? confirmPassword,
    UrlInput? website,
    DateInput? birthdate,
    PhoneInput? phone,
    NonEmptyInput? name,
    FormzSubmissionStatus? status,
  }) {
    return MyFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      website: website ?? this.website,
      birthdate: birthdate ?? this.birthdate,
      phone: phone ?? this.phone,
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [email, password];
}

class DateTextFormatter extends TextInputFormatter {
  static const _maxChars = 8;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    const separator = '/';
    final text = _format(
      newValue.text,
      oldValue.text,
      separator,
    );

    return newValue.copyWith(
      text: text,
      selection: updateCursorPosition(
        oldValue,
        text,
      ),
    );
  }

  String _format(
    String value,
    String oldValue,
    String separator,
  ) {
    final isErasing = value.length < oldValue.length;
    final isComplete = value.length > _maxChars + 2;

    if (!isErasing && isComplete) {
      return oldValue;
    }

    value = value.replaceAll(separator, '');
    final result = <String>[];

    for (var i = 0; i < min(value.length, _maxChars); i++) {
      result.add(value[i]);
      if ((i == 1 || i == 3) && i != value.length - 1) {
        result.add(separator);
      }
    }

    return result.join();
  }

  TextSelection updateCursorPosition(
    TextEditingValue oldValue,
    String text,
  ) {
    final endOffset = max(
      oldValue.text.length - oldValue.selection.end,
      0,
    );

    final selectionEnd = text.length - endOffset;

    return TextSelection.fromPosition(TextPosition(offset: selectionEnd));
  }
}
