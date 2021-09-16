part of 'register_bloc.dart';

enum FormStatus { valid, invalid }

class RegisterState extends Equatable {
  final FormInput emailInput;
  final FormInput passwordInput;
  final SuccessWrapper? submissionState;
  final FormStatus? status;

  const RegisterState({
    this.emailInput = const FormInput(),
    this.passwordInput = const FormInput(),
    this.submissionState,
    this.status,
  });

  RegisterState copyWith(
          {FormInput? emailInput,
          FormInput? passwordInput,
          required SuccessWrapper? submissionState,
          required FormStatus? status}) =>
      RegisterState(
        emailInput: emailInput ?? this.emailInput,
        passwordInput: passwordInput ?? this.passwordInput,
        submissionState: submissionState,
        status: status,
      );

  @override
  List<Object?> get props =>
      [emailInput, passwordInput, submissionState, status];
}
