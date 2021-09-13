import 'package:flutter/material.dart';
import 'package:flutter_architecture/app_route.dart';
import 'package:flutter_architecture/core/data_wrapper.dart';
import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/data/datamanager/user_datamanager.dart';
import 'package:rxdart/rxdart.dart';

class RegisterViewModel {

  // Dependencies

  final DataManager _dataManager;
  final NavigatorState _navigator;

  // Subjects

  final BehaviorSubject<String> _emailSubject;
  Stream<String> get emailStream => _emailSubject.stream;

  final BehaviorSubject<String> _passwordSubject;
  Stream<String> get passwordStream => _passwordSubject.stream;

  final BehaviorSubject<DataState?> _loginStateSubject;
  Stream<DataState?> get loginStateStream => _loginStateSubject.stream;

  // Init

  RegisterViewModel(this._dataManager, this._navigator)
      : _emailSubject = BehaviorSubject.seeded(""),
        _passwordSubject = BehaviorSubject.seeded(""),
        _loginStateSubject = BehaviorSubject.seeded(null);

  // Dispose

  void dispose() {
    _emailSubject.close();
    _passwordSubject.close();
    _loginStateSubject.close();
  }

  // Events

  void setEmail(String email) {
    _emailSubject.sink.add(email);
  }

  void setPassword(String password) {
    _passwordSubject.sink.add(password);
  }

  void onSignIn() async {
    _loginStateSubject.sink.add(DataStateLoading());
    try {
      final result = await _dataManager.register(_emailSubject.value, _passwordSubject.value);
      if (result != null) {
        _loginStateSubject.sink.add(DataStateSuccess());
        _navigator.pushNamed(Routes.userList.path);
      } else {
        _loginStateSubject.sink.add(DataStateError(error: "Fail to login"));
      }
    } catch (error) {
      _loginStateSubject.sink.add(DataStateError(error: error));
    }
  }

}