import 'package:flutter/material.dart';
import 'package:flutter_architecture/app_module.dart';
import 'package:flutter_architecture/core/data_wrapper.dart';
import 'package:flutter_architecture/presentation/common/constants.dart';
import 'package:flutter_architecture/presentation/common/widgets/loading.dart';
import 'package:flutter_architecture/presentation/register/register_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class RegisterScreen extends ConsumerStatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  late final RegisterViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    this._viewModel = RegisterViewModel(ref.read(dataManager), Navigator.of(context));

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Register')
      ),
      body: StreamBuilder<DataState?>(
          stream: _viewModel.loginStateStream,
          builder: (BuildContext context, AsyncSnapshot<DataState?> snapshot) {
            final state = snapshot.data;
            if (state is DataStateLoading) return Loading();
            if (state is DataStateError) return _buildForm(state.error.toString());

            return _buildForm("");
          }),
    );
  }

  Widget _buildForm(String error) {
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
                child: Text(
                  "Register",
                  style: TextStyle(color: Colors.white),
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