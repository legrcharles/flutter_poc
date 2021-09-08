import 'package:flutter/material.dart';
import 'package:flutter_architecture/app_module.dart';
import 'package:flutter_architecture/app_route.dart';
import 'package:flutter_architecture/core/data_wrapper.dart';
import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/presentation/common/constants.dart';
import 'package:flutter_architecture/presentation/common/widgets/loading.dart';
import 'package:flutter_architecture/presentation/signin/signin_viewmodel.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';


class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  late final SignInViewModel _viewModel;

  void _setup(BuildContext context) {
    this._viewModel = SignInViewModel(context.read<DataManager>(), Navigator.of(context));

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
    _setup(context);

    return Scaffold(
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
      body: StreamBuilder<SuccessWrapper?>(
          stream: _viewModel.loginStateStream,
          builder: (BuildContext context, AsyncSnapshot<SuccessWrapper?> snapshot) {
            final state = snapshot.data?.state;
            if (state is StateLoading) return _buildForm(loading: true);
            if (state is StateError) return _buildForm(error: state.error.toString());

            return _buildForm();
          }),
    );
  }

  Widget _buildForm({String error = "", bool loading = false}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: textInputDecoration.copyWith(hintText: 'email'),
              validator: (value) => value == null || value.isEmpty ? "Enter an email" : null,
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
              child: loading ?
                SpinKitRipple(
                  color: Colors.white,
                  size: 20.0,
                ) : Container(
                  child: Center(
                    child: Text(
                      "Sign In",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              onPressed: () async {
                if (_formKey.currentState?.validate() == true) {
                  _viewModel.onSignIn();
                }
              },
            ),
            SizedBox(height: 10.0),
            (error.isEmpty) ?
            SizedBox.shrink()
                :
            Text(
              error,
              style: TextStyle(color: Colors.red, fontSize: 15.0),
            )

          ],
        ),
      )
    );
  }
}