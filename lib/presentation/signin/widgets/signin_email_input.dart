import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/form_input.dart';
import 'package:flutter_architecture/presentation/signin/bloc/signin_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInEmailInput extends StatelessWidget {
  const SignInEmailInput({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        final inputState = state.emailInput.state;
        final inputValue = state.emailInput.value;

        return TextFormField(
          controller: TextEditingController(text: inputValue)
            ..selection = TextSelection.fromPosition(TextPosition(offset: inputValue.length),
            ),
          focusNode: focusNode,
          decoration: InputDecoration(
            icon: const Icon(Icons.email),
            labelText: 'Email',
            helperText: 'A complete, valid email e.g. joe@gmail.com',
            errorText: inputState is InputInvalid ? inputState.error.toString() : null,
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            context.read<SignInBloc>().add(EmailChanged(email: value));
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}