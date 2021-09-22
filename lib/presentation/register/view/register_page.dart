import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_architecture/app_route.dart';
import 'package:flutter_architecture/core/success_wrapper.dart';
import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/presentation/common/utils/alert_utils.dart';
import 'package:flutter_architecture/presentation/common/utils/color_utils.dart';
import 'package:flutter_architecture/presentation/register/bloc/register_bloc.dart';
import 'package:flutter_architecture/presentation/register/widgets/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(context.read<DataManager>()),
      child: const RegisterView(),
    );
  }
}

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      /*
        appBar: PlatformAppBar(
          backgroundColor: Colors.transparent,
          material: (context, platform) => MaterialAppBarData(
            elevation: 0
          ),
          cupertino: (context, platform) {
              return CupertinoNavigationBarData(
                  transitionBetweenRoutes: true,
                  automaticallyImplyLeading: true,
                  previousPageTitle: LocaleKeys.home_title.tr());
            },
        ),
       */
        body: BlocListener<RegisterBloc, RegisterState>(
            listener: (context, state) {
              final submissionState = state.submissionState;

              if (submissionState is StateSuccess) {
                Navigator.of(context).pushReplacementNamed(Routes.home.path);
              }
              if (submissionState is StateError) {
                AlertUtils.showError(context, submissionState.error.toString(), androidSnakeBar: true);
              }
            },
            child: Stack(
              children: <Widget>[
                _buildBackground(),
                _buildContent()
              ],
            )
        )
    );
  }

  Widget _buildBackground() {
    return Column(
      children: <Widget>[
        _buildHeader(),
        Expanded(child: Container()),
        _buildFooter(),
      ],
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: SvgPicture.asset(
            'assets/images/login/header.svg',
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          top: 36,
          left: 8,
          child: PlatformIconButton(
            padding: const EdgeInsets.all(4.0),
            icon: Icon(
              Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Register",
              style: GoogleFonts.permanentMarker(color: AppColor.text, fontSize: 40),
            ),
            Text(
              "Créez votre compte sur l'application !",
              style: TextStyle(color: AppColor.text, fontSize: 15),
            ),
            const SizedBox(height: 30),
            RegisterEmailInput(focusNode: _emailFocusNode),
            const SizedBox(height: 16),
            RegisterPasswordInput(focusNode: _passwordFocusNode),
            const SizedBox(height: 24),
            const RegisterSubmitButton()
          ],
        ),
      ),
    ]);
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
