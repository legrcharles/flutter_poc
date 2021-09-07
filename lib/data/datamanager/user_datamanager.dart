import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/data/models/appuser.dart';

extension UserDataManager on DataManager {

  Stream<AppUser?> get user => authProvider.user;

  AppUser? get currentUser => authProvider.currentUser;

  Future<AppUser?> signIn(String email, String password) async {
    return authProvider.signInWithEmailAndPassword(email, password);
  }

  Future<AppUser?> register(String email, String password) async {
    return authProvider.registerWithEmailAndPassword(email, password);
  }

  Future signOut() async => await authProvider.signOut();
}