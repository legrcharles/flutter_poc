import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture/app_module.dart';
import 'package:flutter_architecture/app_route.dart';
import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/data/datamanager/user_datamanager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

final signInViewModelProvider = Provider((ref) => SignInViewModel(ref.read(dataManager)));

class SignInViewModel {

  // Dependencies

  final DataManager _dataManager;

  // Subjects

  final BehaviorSubject<String> _emailSubject;
  Stream<String> get emailStream => _emailSubject.stream;

  final BehaviorSubject<String> _passwordSubject;
  Stream<String> get passwordStream => _passwordSubject.stream;

  // Init

  SignInViewModel(this._dataManager)
      : _emailSubject = BehaviorSubject.seeded(""),
        _passwordSubject = BehaviorSubject.seeded("");

  // Dispose

  void dispose() {
    print("dispose");
    _emailSubject.close();
    _passwordSubject.close();
  }

  // Events

  void setEmail(String email) {
    print("test");
    print(email);
    _emailSubject.sink.add(email);
  }

  void setPassword(String password) {
    print("test pwd");
    print(password);
    _passwordSubject.sink.add(password);
  }

  void onSignIn(BuildContext context) {
    print(_emailSubject.value);
    print(_passwordSubject.value);
    /*
    _dataManager.signIn(_emailSubject.value, _passwordSubject.value)
        .then((value) => {
            Navigator.of(context).pushNamed(Routes.userList.path)
        });

     */
  }
}