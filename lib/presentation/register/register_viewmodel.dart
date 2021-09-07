import 'package:flutter_architecture/app_module.dart';
import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/data/datamanager/user_datamanager.dart';
import 'package:flutter_architecture/data/models/appuser.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerViewModelProvider = Provider((ref) => RegisterViewModel(ref.read(dataManager)));

class RegisterViewModel {

  // Dependencies

  final DataManager _dataManager;

  // Subjects

  late final Stream<AppUser?> currentUser;

  // Init

  RegisterViewModel(this._dataManager) {
    currentUser = _dataManager.user;
  }

  // Dispose

  void dispose() {

  }

}