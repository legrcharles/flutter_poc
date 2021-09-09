import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/data/datamanager/user_datamanager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc

class AuthSplashBloc extends Bloc<AuthSplashEvent, AuthSplashState> {

  final DataManager _dataManager;

  AuthSplashBloc(this._dataManager) : super(AuthSplashState.initial);

  @override
  void onTransition(Transition<AuthSplashEvent, AuthSplashState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<AuthSplashState> mapEventToState(AuthSplashEvent event) async* {
    if (event is ViewCreated) {
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

class ViewCreated extends AuthSplashEvent {}