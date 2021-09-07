import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_architecture/data/models/appuser.dart';
import 'package:flutter_architecture/data/provider/mapper/firebase_user_mapper.dart';

abstract class FirebaseAuthProviderInterface {
  Stream<AppUser?> get user;
  AppUser? get currentUser;
  Future signInWithEmailAndPassword(String email, String password);
  Future registerWithEmailAndPassword(String name, String email, String password);
  void dispose();
}

class FirebaseAuthProvider extends FirebaseAuthProviderInterface {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<AppUser?> get user => _auth.authStateChanges().map(FirebaseUserMapper.map);

  AppUser? get currentUser => FirebaseUserMapper.map(_auth.currentUser);

  Future signInWithEmailAndPassword(String email, String password) async {
    UserCredential result =
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    User? user = result.user;
    return FirebaseUserMapper.map(user);
  }

  Future registerWithEmailAndPassword(String name, String email, String password) async {
      UserCredential result =
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      if (user == null) {
        throw Exception("No user found");
      } else {
        return FirebaseUserMapper.map(user);
      }
  }

  Future signOut() async => await _auth.signOut();

  @override
  void dispose() {}
}