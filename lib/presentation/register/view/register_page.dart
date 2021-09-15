import 'package:flutter/material.dart';
import 'package:flutter_architecture/app_route.dart';
import 'package:flutter_architecture/core/success_wrapper.dart';
import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/presentation/register/bloc/register_bloc.dart';
import 'package:flutter_architecture/presentation/register/widgets/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          final submissionState = state.submissionState;

          if (submissionState is StateSuccess) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            showDialog<void>(
              context: context,
              builder: (_) =>
                  RegisterSuccessDialog(onPressed: () {
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
              RegisterEmailInput(focusNode: _emailFocusNode),
              RegisterPasswordInput(focusNode: _passwordFocusNode),
              const SizedBox(height: 50),
              const RegisterSubmitButton(),
            ],
          ),
        )
      )
    );
  }
}
