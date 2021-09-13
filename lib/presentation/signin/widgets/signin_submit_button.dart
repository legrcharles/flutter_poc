import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/success_wrapper.dart';
import 'package:flutter_architecture/presentation/common/widgets/loading.dart';
import 'package:flutter_architecture/presentation/signin/bloc/signin_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInSubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        //print("isFormValid ${state.isFormValid}");
        return ElevatedButton(
          onPressed: (state.status == FormStatus.valid)
              ? () => context.read<SignInBloc>().add(FormSubmitted())
              : null,
          child: Container(
            width: 200,
            child: state.submissionState is StateLoading ? Loading() : Center(child: Text('Submit')),
          ),
        );
      },
    );
  }
}