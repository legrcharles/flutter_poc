import 'package:flutter/material.dart';
import 'package:flutter_architecture/app_route.dart';
import 'package:flutter_architecture/presentation/authsplash/authsplash_viewmodel.dart';
import 'package:flutter_architecture/presentation/common/widgets/loading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthSplashScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _viewModel = ref.read(authSplashViewModelProvider);

    _viewModel.userConnectedStream.listen((event) {
      if (event) {
        Navigator.of(context).pushReplacementNamed(Routes.userList.path);
      } else {
        Navigator.of(context).pushReplacementNamed(Routes.signin.path);
      }
    });

    return Loading();
  }
}