import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_architecture/data/models/appuser.dart';
import 'package:flutter_architecture/data/provider/firebaseauth/mapper/firebase_user_mapper.dart';

abstract class FirebaseAuthProviderInterface {
  Stream<AppUser?> get user;
  AppUser? get currentUser;
  Future<AppUser?> signInWithEmailAndPassword(String email, String password);
  Future<AppUser?> registerWithEmailAndPassword(String email, String password);
  void dispose();
}

class FirebaseAuthProvider extends FirebaseAuthProviderInterface {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Stream<AppUser?> get user => _auth.authStateChanges().map(FirebaseUserMapper.map);

  @override
  AppUser? get currentUser => FirebaseUserMapper.map(_auth.currentUser);

  @override
  Future<AppUser?> signInWithEmailAndPassword(String email, String password) async {
    UserCredential result =
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    User? user = result.user;
    return FirebaseUserMapper.map(user);
  }

  @override
  Future<AppUser?> registerWithEmailAndPassword(String email, String password) async {
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