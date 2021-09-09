import 'package:flutter/material.dart';
import 'package:flutter_architecture/presentation/common/widgets/loading.dart';
import 'package:flutter_architecture/presentation/signin/bloc/signin_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInSubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.status == FormStatus.success
              ? () => context.read<SignInBloc>().add(FormSubmitted())
              : null,
          child: state.status == FormStatus.loading ? Loading() : Text('Submit'),
        );
      },
    );
  }
}