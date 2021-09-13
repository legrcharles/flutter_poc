import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/form_input.dart';
import 'package:flutter_architecture/presentation/signin/bloc/signin_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPasswordInput extends StatelessWidget {
  const SignInPasswordInput({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        final inputState = state.passwordInput.state;
        final inputValue = state.passwordInput.value;

        return TextFormField(
          controller: TextEditingController(text: inputValue)
            ..selection = TextSelection.fromPosition(TextPosition(offset: inputValue.length),
            ),
          focusNode: focusNode,
          decoration: InputDecoration(
            icon: const Icon(Icons.lock),
            helperText:
            '''Password should be at least 8 characters with at least one letter and number''',
            helperMaxLines: 2,
            labelText: 'Password',
            errorMaxLines: 2,
            errorText: inputState is InputInvalid ? inputState.error.toString() : null,
          ),
          obscureText: true,
          onChanged: (value) {
            context.read<SignInBloc>().add(PasswordChanged(password: value));
          },
          textInputAction: TextInputAction.done,
        );
      },
    );
  }
}