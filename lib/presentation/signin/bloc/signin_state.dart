part of 'signin_bloc.dart';

enum FormStatus { valid, invalid }

class SignInState extends Equatable {
  final FormInput emailInput;
  final FormInput passwordInput;
  final SuccessWrapper? submissionState;
  final FormStatus? status;

  const SignInState({
    this.emailInput = const FormInput(),
    this.passwordInput = const FormInput(),
    this.submissionState,
    this.status,
  });

  SignInState copyWith({ FormInput? emailInput, FormInput? passwordInput, required SuccessWrapper? submissionState, required FormStatus? status}) =>
      SignInState(
        emailInput: emailInput ?? this.emailInput,
        passwordInput: passwordInput ?? this.passwordInput,
        submissionState: submissionState ,
        status: status,
      );

  @override
  List<Object?> get props => [emailInput, passwordInput, submissionState, status];
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