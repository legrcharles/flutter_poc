import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture/app_route.dart';
import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/data/datamanager/user_datamanager.dart';

class AuthSplashViewModel {

  // Dependencies

  final DataManager _dataManager;
  final NavigatorState _navigator;

  // Init

  AuthSplashViewModel(this._dataManager, this._navigator);

  // event

  void onCreate() {
    if (_dataManager.currentUser != null) {
      _navigator.pushReplacementNamed(Routes.userList.path);
    } else {
      _navigator.pushReplacementNamed(Routes.signin.path);
    }
  }

}