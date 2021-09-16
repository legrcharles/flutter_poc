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

  SignInState copyWith(
          {FormInput? emailInput,
          FormInput? passwordInput,
          required SuccessWrapper? submissionState,
          required FormStatus? status}) =>
      SignInState(
        emailInput: emailInput ?? this.emailInput,
        passwordInput: passwordInput ?? this.passwordInput,
        submissionState: submissionState,
        status: status,
      );

  @override
  List<Object?> get props =>
      [emailInput, passwordInput, submissionState, status];

  @override
  String toString() {
    return 'SignInState { emailInput: $emailInput, passwordInput: $passwordInput, submissionState: $submissionState, status: $status }';
  }
}
