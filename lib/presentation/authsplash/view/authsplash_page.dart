import 'package:flutter/material.dart';
import 'package:flutter_architecture/app_route.dart';
import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/presentation/authsplash/bloc/authsplash_bloc.dart';
import 'package:flutter_architecture/presentation/common/widgets/loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class AuthSplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthSplashBloc(context.read<DataManager>()),
      child: AuthSplashView(),
    );
  }
}

class AuthSplashView extends StatefulWidget {
  const AuthSplashView({Key? key}) : super(key: key);

  @override
  _AuthSplashViewState createState() => _AuthSplashViewState();
}

class _AuthSplashViewState extends State<AuthSplashView> {

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      context.read<AuthSplashBloc>().add(ViewCreated());
    });
    return BlocListener<AuthSplashBloc, AuthSplashState>(
        listener: (context, state) {
          if (state == AuthSplashState.connected) {
            Navigator.of(context).pushReplacementNamed(Routes.userList.path);
          } else if (state == AuthSplashState.notConnected) {
            Navigator.of(context).pushReplacementNamed(Routes.signin.path);
          }
        },
        child: Container(
            color: Colors.white,
            child: Loading()
        )
    );
  }
}
