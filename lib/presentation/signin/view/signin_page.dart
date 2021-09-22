import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/app_route.dart';
import 'package:flutter_architecture/core/success_wrapper.dart';
import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/presentation/common/utils/alert_utils.dart';
import 'package:flutter_architecture/presentation/common/utils/color_utils.dart';
import 'package:flutter_architecture/presentation/signin/bloc/signin_bloc.dart';
import 'package:flutter_architecture/presentation/signin/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(context.read<DataManager>()),
      child: const SignInView(),
    );
  }
}

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<SignInBloc>().add(EmailUnfocused());
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        context.read<SignInBloc>().add(PasswordUnfocused());
      }
    });
  }

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
        body: BlocListener<SignInBloc, SignInState>(
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
    return SizedBox(
      width: double.infinity,
      child: SvgPicture.asset(
        'assets/images/login/header.svg',
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _buildContent() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Connexion",
              style: GoogleFonts.permanentMarker(color: AppColor.text, fontSize: 40),
            ),
            const SizedBox(height: 30),
            SignInEmailInput(focusNode: _emailFocusNode),
            const SizedBox(height: 16),
            SignInPasswordInput(focusNode: _passwordFocusNode),
            const SizedBox(height: 24),
            const SignInSubmitButton(),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Pas encore de compte ?",
                  style: TextStyle(color: AppColor.text, fontSize: 14),
                ),
                TextButton(
                    child: Text(
                      "Regsiter",
                      style: TextStyle(color: AppColor.secondary, fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => Navigator.of(context).pushNamed(Routes.register.path))
              ],
            )
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
