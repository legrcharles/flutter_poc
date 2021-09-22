import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/form_input.dart';
import 'package:flutter_architecture/presentation/common/utils/color_utils.dart';
import 'package:flutter_architecture/presentation/signin/bloc/signin_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPasswordInput extends StatelessWidget {
  const SignInPasswordInput({Key? key, required this.focusNode})
      : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        final inputState = state.passwordInput.state;
        final inputValue = state.passwordInput.value;

        return Column(
          children: [
            SizedBox(
                width: double.infinity,
                child: Text(
                  "Mot de passe",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: AppColor.text, fontSize: 18),
                )),
            const SizedBox(height: 8,),
            Container(
              decoration: BoxDecoration(
                color: AppColor.backgroundLight1,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                cursorColor: AppColor.text,
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 16, right: 16),
                  border: InputBorder.none,
                  hintText: "Your password",
                  focusColor: AppColor.text,
                ),
                controller: TextEditingController(text: inputValue)
                  ..selection = TextSelection.fromPosition(
                    TextPosition(offset: inputValue.length),
                  ),
                focusNode: focusNode,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  context.read<SignInBloc>().add(PasswordChanged(password: value));
                },
                textInputAction: TextInputAction.done,
              ),
            ),
            const SizedBox(height: 8,),
            SizedBox(
                width: double.infinity,
                child: Text(
                  inputState is InputInvalid ? inputState.error.toString() : "",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: AppColor.error, fontSize: 14),
                )),
          ],
        );
      },
    );
  }
}
