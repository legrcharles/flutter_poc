import 'package:flutter/material.dart';
import 'package:flutter_architecture/app_route.dart';
import 'package:flutter_architecture/core/success_wrapper.dart';
import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/presentation/signin/bloc/signin_bloc.dart';
import 'package:flutter_architecture/presentation/signin/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Sign in'),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: const Text("Register",
                style: TextStyle(color: Colors.white)),
            onPressed: () => Navigator.of(context).pushReplacementNamed(Routes.register.path),
          ),
        ],
      ),
      body: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          final submissionState = state.submissionState;

          if (submissionState is StateSuccess) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            showDialog<void>(
              context: context,
              builder: (_) =>
                  SignInSuccessDialog(onPressed: () {
                    Navigator.of(context).pushNamed(Routes.userList.path);
                  }),
            );
          }
          if (submissionState is StateLoading) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Submitting...')),
              );
          }
          if (submissionState is StateError) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text(submissionState.error.toString())),
              );
          }

        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SignInEmailInput(focusNode: _emailFocusNode),
              SignInPasswordInput(focusNode: _passwordFocusNode),
              const SizedBox(height: 50),
              const SignInSubmitButton(),
            ],
          ),
        )
      )
    );
  }
}
