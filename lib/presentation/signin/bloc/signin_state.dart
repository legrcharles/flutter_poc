part of 'signin_bloc.dart';

enum FormInputStatus { initial, filled, valid, invalid }

class FormInput extends Equatable {

  final String value;
  final FormInputStatus status;
  
  const FormInput({
    this.value = '',
    this.status = FormInputStatus.initial
  });

  FormInput copyWith({ String? value, FormInputStatus? status }) =>
    FormInput(value: value ?? this.value, status: status ?? this.status);
  
  @override
  List<Object?> get props => [value, status];
}

enum FormStatus { initial, valid, invalid, submissionInProgress, submissionSuccess, submissionFailure }

class SignInState extends Equatable {
  final FormInput emailInput;
  final FormInput passwordInput;
  final String submissionError;
  final FormStatus status;

  const SignInState({
    this.emailInput = const FormInput(),
    this.passwordInput = const FormInput(),
    this.submissionError = '',
    this.status = FormStatus.initial,
  });

  SignInState copyWith({ FormInput? emailInput, FormInput? passwordInput, String? submissionError, FormStatus? status}) =>
      SignInState(
        emailInput: emailInput ?? this.emailInput,
        passwordInput: passwordInput ?? this.passwordInput,
        submissionError: submissionError ?? this.submissionError,
        status: status ?? this.status,
      );

  @override
  List<Object> get props => [emailInput, passwordInput, submissionError, status];
}

/*
class SignInState2 extends Equatable {
  final String email;
  final bool isEmailValid;
  final String password;
  final bool isPasswordValid;
  final String submissionError;
  final FormStatus status;

  const SignInState({
    this.email = '',
    this.isEmailValid = true,
    this.password = '',
    this.isPasswordValid = true,
    this.submissionError = '',
    this.status = FormStatus.initial,
  });

  SignInState copyWith({ String? email, bool? isEmailValid, String? password, bool? isPasswordValid, String? submissionError, FormStatus? status}) =>
      SignInState(
        email: email ?? this.email,
        isEmailValid: isEmailValid ?? this.isEmailValid,
        password: password ?? this.password,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        submissionError: submissionError ?? this.submissionError,
        status: status ?? this.status,
      );

  @override
  List<Object> get props => [email, isEmailValid, password, isPasswordValid, submissionError, status];
}*/