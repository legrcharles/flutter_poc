import 'package:flutter/material.dart';
import 'package:flutter_architecture/app_module.dart';
import 'package:flutter_architecture/app_route.dart';
import 'package:flutter_architecture/presentation/common/constants.dart';
import 'package:flutter_architecture/presentation/common/widgets/loading.dart';
import 'package:flutter_architecture/presentation/signin/signin_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class SignInScreen extends ConsumerStatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  late final SignInViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    this._viewModel = SignInViewModel(ref.read(dataManager));

    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _observeViewData();
  }

  void _observeViewData() {
    _viewModel.emailStream.listen((event) {
      _emailController.text = event;
      _emailController.selection = TextSelection.fromPosition(TextPosition(offset: _emailController.text.length));
    });

    _viewModel.passwordStream.listen((event) {
      _passwordController.text = event;
      _passwordController.selection = TextSelection.fromPosition(TextPosition(offset: _passwordController.text.length));
    });
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Sign in'),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: Text("Register",
                style: TextStyle(color: Colors.white)),
            onPressed: () => Navigator.of(context).pushNamed(Routes.register.path),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: textInputDecoration.copyWith(hintText: 'email'),
                validator: (value) =>
                value == null || value.isEmpty ? "Enter an email" : null,
                onChanged: (value) {
                  _viewModel.setEmail(value);
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _passwordController,
                decoration: textInputDecoration.copyWith(hintText: 'password'),
                obscureText: true,
                validator: (value) => value != null && value.length < 6
                    ? "Enter a password with at least 6 characters"
                    : null,
                onChanged: (value) {
                  _viewModel.setPassword(value);
                },
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                child: Text(
                  "Sign In",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState?.validate() == true) {
                    _viewModel.onSignIn(context);
                  }
                },
              ),
              SizedBox(height: 10.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 15.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}