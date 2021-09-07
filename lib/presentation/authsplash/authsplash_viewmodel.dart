import 'package:flutter_architecture/app_module.dart';
import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/data/datamanager/user_datamanager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

final authSplashViewModelProvider = Provider((ref) => AuthSplashViewModel(ref.read(dataManager)));

class AuthSplashViewModel {

  // Dependencies

  final DataManager _dataManager;

  // Subjects

  final BehaviorSubject<bool> _userConnectedSubject = BehaviorSubject.seeded(false);
  Stream<bool> get userConnectedStream => _userConnectedSubject.stream;

  // Init

  AuthSplashViewModel(this._dataManager) {
    _userConnectedSubject.sink.add(_dataManager.currentUser != null);
  }

  // Dispose

  void dispose() {
    _userConnectedSubject.close();
  }
}