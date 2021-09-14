import 'package:equatable/equatable.dart';
import 'dart:developer' as dev;
import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/data/datamanager/user_datamanager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc

class AuthSplashBloc extends Bloc<AuthSplashEvent, AuthSplashState> {

  final DataManager _dataManager;

  AuthSplashBloc(this._dataManager) : super(AuthSplashState.initial);

  @override
  void onTransition(Transition<AuthSplashEvent, AuthSplashState> transition) {
    dev.log("SignInBloc Transition :\ncurrentState : ${transition.currentState.toString()} \n"
        "event : ${transition.event.toString()} \n"
        "nextState : ${transition.nextState.toString()}");
    super.onTransition(transition);
  }

  @override
  Stream<AuthSplashState> mapEventToState(AuthSplashEvent event) async* {
    if (event is LoadData) {
      yield _dataManager.currentUser != null ? AuthSplashState.connected : AuthSplashState.notConnected;
    }
  }
}

// State

enum AuthSplashState {
  initial, connected, notConnected
}

// Events

abstract class AuthSplashEvent extends Equatable {
  const AuthSplashEvent();

  @override
  List<Object> get props => [];
}

class LoadData extends AuthSplashEvent {}