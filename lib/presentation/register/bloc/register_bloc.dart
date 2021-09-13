import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/core/form_input.dart';
import 'package:flutter_architecture/core/success_wrapper.dart';
import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/data/datamanager/user_datamanager.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {

  final DataManager _dataManager;

  RegisterBloc(this._dataManager) : super(const RegisterState());

  @override
  void onTransition(Transition<RegisterEvent, RegisterState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
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
          await _dataManager.register(state.emailInput.value, state.passwordInput.value);
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
      return InputInvalid(error: "L'email doit contenir au moins 4 caractères.");
    }
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(state.emailInput.value)) {
      return InputInvalid(error: "Merci de renseigner une adresse email valide.");
    }
    return InputValid();
  }

  InputStateWrapper get passwordState {
    if (state.passwordInput.value.trim().length < 6) {
      return InputInvalid(error: "Le mot de passe doit contenir au moins 6 caractères");
    }
    return InputValid();
  }
}