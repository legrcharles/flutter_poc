import 'package:flutter/material.dart';
import 'package:flutter_architecture/app_module.dart';
import 'package:flutter_architecture/presentation/authsplash/authsplash_viewmodel.dart';
import 'package:flutter_architecture/presentation/common/widgets/loading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class AuthSplashScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = AuthSplashViewModel(ref.read(dataManager), Navigator.of(context));

    Future.delayed(const Duration(seconds: 1), () => viewModel.onCreate());

    return Loading();
  }

}