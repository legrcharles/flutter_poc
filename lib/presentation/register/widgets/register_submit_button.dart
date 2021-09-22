import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/success_wrapper.dart';
import 'package:flutter_architecture/presentation/common/widgets/app_button.dart';
import 'package:flutter_architecture/presentation/register/bloc/register_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterSubmitButton extends StatelessWidget {
  const RegisterSubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      //buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        //print("isFormValid ${state.isFormValid}");
        return SizedBox(
          width: 250,
          child: AppButton(
            style: AppButtonStyle.secondary,
            title: 'Submit',
            loading: state.submissionState is StateLoading,
            onPressed: () => context.read<RegisterBloc>().add(FormSubmitted()),
          ),
        );
      },
    );
  }
}
