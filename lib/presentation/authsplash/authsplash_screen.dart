import 'package:flutter/material.dart';
import 'package:flutter_architecture/app_module.dart';
import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/presentation/authsplash/authsplash_viewmodel.dart';
import 'package:flutter_architecture/presentation/common/widgets/loading.dart';
import 'package:provider/provider.dart';


class AuthSplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = AuthSplashViewModel(Provider.of<DataManager>(context), Navigator.of(context));

    Future.delayed(const Duration(seconds: 1), () => viewModel.onCreate());

    return Loading();
  }

}