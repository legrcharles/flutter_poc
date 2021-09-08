part of 'signin_bloc.dart';

enum FormStatus { initial, loading, success, failure }

class SignInState extends Equatable {
  final String email;
  final String password;
  final FormStatus status;

  const SignInState({
    this.email = '',
    this.password = '',
    this.status = FormStatus.initial,
  });

  SignInState copyWith({ String? email, String? password, FormStatus? status}) =>
      SignInState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
      );

  @override
  List<Object> get props => [email, password, status];
}