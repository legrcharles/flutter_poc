import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_architecture/data/models/appuser.dart';

class FirebaseUserMapper {
  static AppUser? map(User? dto) => dto != null ? AppUser(dto.uid) : null;
}
