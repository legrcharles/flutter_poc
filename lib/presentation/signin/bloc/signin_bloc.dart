import 'dart:async';
import 'dart:developer' as dev;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/core/form_input.dart';
import 'package:flutter_architecture/core/success_wrapper.dart';
import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/data/datamanager/user_datamanager.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {

  final DataManager _dataManager;

  SignInBloc(this._dataManager) : super(const SignInState());

  @override
  void onTransition(Transition<SignInEvent, SignInState> transition) {
    dev.log("SignInBloc Transition :\ncurrentState : ${transition.currentState.toString()} \n"
        "event : ${transition.event.toString()} \n"
        "nextState : ${transition.nextState.toString()}");
    super.onTransition(transition);
  }

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is EmailChanged) {
      yield state.copyWith(
          emailInput: state.emailInput.copyWith(value: event.email, state: null),
          submissionState: null,
          status: null
      );

    } else if (event is PasswordChanged) {
      yield state.copyWith(
          passwordInput: state.passwordInput.copyWith(value: event.password, state: null),
          submissionState: null,
          status: null
      );

    } else if (event is EmailUnfocused) {
      yield state.copyWith(
          emailInput: state.emailInput.copyWith(state: emailState),
          status: formStatus,
          submissionState: null
      );

    } else if (event is PasswordUnfocused) {
      yield state.copyWith(
          passwordInput: state.passwordInput.copyWith(state: passwordState),
          status: formStatus,
          submissionState: null
      );

    } else if (event is FormSubmitted) {
      yield state.copyWith(
          emailInput: state.emailInput.copyWith(state: emailState),
          passwordInput: state.passwordInput.copyWith(state: passwordState),
          status: formStatus,
          submissionState: null
      );

      if (formStatus == FormStatus.valid) {
        yield state.copyWith(submissionState: StateLoading(), status: formStatus);

        try {
          await _dataManager.signIn(state.emailInput.value, state.passwordInput.value);
          yield state.copyWith(submissionState: StateSuccess(), status: formStatus);
        } catch (error) {
          yield state.copyWith(
              passwordInput: state.passwordInput.copyWith(value: "", state: null),
              submissionState: StateError(error: error.toString()),
              status: null);
        }
      }
    }
  }

  FormStatus get formStatus {
    if (emailState is InputValid && passwordState is InputValid) {
      return FormStatus.valid;
    }

    return FormStatus.invalid;
  }

  InputStateWrapper get emailState {
    if (state.emailInput.value.trim().length < 4) {
      return const InputInvalid(error: "L'email doit contenir au moins 4 caractères");
    }
    return InputValid();
  }

  InputStateWrapper get passwordState {
    if (state.passwordInput.value.trim().length < 4) {
      return const InputInvalid(error: "Le mot de passe doit contenir au moins 4 caractères");
    }
    return InputValid();
  }
}