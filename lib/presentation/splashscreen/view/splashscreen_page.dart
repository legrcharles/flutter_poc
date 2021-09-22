import 'package:flutter/material.dart';
import 'package:flutter_architecture/app_route.dart';
import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/presentation/splashscreen/bloc/splashscreen_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthSplashBloc(context.read<DataManager>()),
      child: const SplashScreenView(),
    );
  }
}

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  _SplashScreenViewState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      context.read<AuthSplashBloc>().add(LoadData());
    });
    return BlocListener<AuthSplashBloc, AuthSplashState>(
        listener: (context, state) {
          Future.delayed(const Duration(seconds: 2), () {
            if (state == AuthSplashState.connected) {
              Navigator.of(context).pushReplacementNamed(Routes.home.path);
            } else if (state == AuthSplashState.notConnected) {
              Navigator.of(context).pushReplacementNamed(Routes.signin.path);
            }
          });
        },
        child: PlatformScaffold(
            body: Column(
              children: <Widget>[
                _buildHeader(),
                Expanded(
                    child: Center(child: PlatformCircularProgressIndicator())
                ),
                _buildFooter(),
              ],
            )
        )
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      width: double.infinity,
      child: SvgPicture.asset(
        'assets/images/login/header.svg',
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _buildFooter() {
    return SizedBox(
      width: double.infinity,
      height: 150,
      child: SvgPicture.asset(
        'assets/images/login/footer.svg',
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
      ),
    );
  }
}
