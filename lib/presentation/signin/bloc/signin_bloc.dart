import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/data/datamanager/user_datamanager.dart';


part 'signin_event.dart';
part 'signin_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {

  final DataManager _dataManager;

  SignInBloc(this._dataManager) : super(const SignInState());

  @override
  void onTransition(Transition<SignInEvent, SignInState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is EmailChanged) {
      yield state.copyWith(
          emailInput: state.emailInput.copyWith(value: event.email, status: FormInputStatus.filled),
        //  status: FormStatus.initial
      );

    } else if (event is PasswordChanged) {
      yield state.copyWith(
          passwordInput: state.passwordInput.copyWith(value: event.password, status: FormInputStatus.filled),
         // status: FormStatus.initial
      );

    } else if (event is EmailUnfocused) {
      yield state.copyWith(
          emailInput: state.emailInput.copyWith(status: isEmailValid ? FormInputStatus.valid : FormInputStatus.invalid),
          status: isFormValid ? FormStatus.valid : FormStatus.invalid
      );

    } else if (event is PasswordUnfocused) {
      yield state.copyWith(
          passwordInput: state.passwordInput.copyWith(status: isPasswordValid ? FormInputStatus.valid : FormInputStatus.invalid),
          status: isFormValid ? FormStatus.valid : FormStatus.invalid
      );

    } else if (event is FormSubmitted) {
      yield state.copyWith(
          emailInput: state.emailInput.copyWith(status: isEmailValid ? FormInputStatus.valid : FormInputStatus.invalid),
          passwordInput: state.passwordInput.copyWith(status: isPasswordValid ? FormInputStatus.valid : FormInputStatus.invalid),
          status: isFormValid ? FormStatus.valid : FormStatus.invalid
      );

      if (isFormValid) {
        yield state.copyWith(status: FormStatus.submissionInProgress);

        try {
          await _dataManager.signIn(state.emailInput.value, state.passwordInput.value);
          yield state.copyWith(status: FormStatus.submissionSuccess);
        } catch (error) {
          yield state.copyWith(
              passwordInput: state.passwordInput.copyWith(value: "", status: FormInputStatus.initial),
              submissionError: error.toString(),
              status: FormStatus.submissionFailure);
        }
      }
    }
  }

  bool get isFormValid => isEmailValid && isPasswordValid;

  bool get isEmailValid => state.emailInput.value.trim().length > 4;
  bool get isPasswordValid => state.passwordInput.value.trim().length > 4;
}