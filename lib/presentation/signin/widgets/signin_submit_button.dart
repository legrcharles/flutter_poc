import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/success_wrapper.dart';
import 'package:flutter_architecture/presentation/common/widgets/app_button.dart';
import 'package:flutter_architecture/presentation/signin/bloc/signin_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInSubmitButton extends StatelessWidget {
  const SignInSubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      //buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        //print("isFormValid ${state.isFormValid}");
        return SizedBox(
          width: 250,
          child: AppButton(
            style: AppButtonStyle.secondary,
            title: 'Submit',
            loading: state.submissionState is StateLoading,
            onPressed: () => context.read<SignInBloc>().add(FormSubmitted()),
          ),
        );
      },
    );
  }
}
