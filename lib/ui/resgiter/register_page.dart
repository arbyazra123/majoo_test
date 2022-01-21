import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majootestcase/bloc/auth_bloc/auth_bloc_cubit.dart';
import 'package:majootestcase/common/widget/custom_button.dart';
import 'package:majootestcase/common/widget/text_form_field.dart';
import 'package:majootestcase/models/user.dart';

class RegisterPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<RegisterPage> {
  final _usernameController = TextController();
  final _emailController = TextController();
  final _passwordController = TextController();
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  bool _isObscurePassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBlocCubit, AuthBlocState>(
        listener: (context, state) {
          if (state is AuthBlocRegisteredState) {
            ScaffoldMessenger.of(context)..hideCurrentSnackBar();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(
                  content: Text("Berhasil Mendaftar"),
                  duration: Duration(seconds: 1),
                ))
                .closed
                .then((value) {
              Navigator.pop(context);
            });
          }
          if (state is AuthBlocErrorState) {
            ScaffoldMessenger.of(context)..hideCurrentSnackBar();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 75, left: 25, bottom: 25, right: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Registrasi',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    // color: colorBlue,
                  ),
                ),
                Text(
                  'Silahkan daftar terlebih dahulu',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 9,
                ),
                _form(),
                SizedBox(
                  height: 50,
                ),
                CustomButton(
                  text: 'Resgiter',
                  onPressed: _handleRegister,
                  height: 100,
                ),
                SizedBox(
                  height: 50,
                ),
                _handleBackLogin(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _form() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextFormField(
            context: context,
            controller: _usernameController,
            isEmail: true,
            hint: 'arbyazra',
            label: 'Username',
            validator: (val) {
              // final pattern = new RegExp(r'([\d\w]{1,}@[\w\d]{1,}\.[\w]{1,})');
              if (val != null)
                return null;
              else
                "Username tidak boleh kosong"!;
              // return pattern.hasMatch(val) ? null : 'email is invalid';
            },
          ),
          CustomTextFormField(
            context: context,
            controller: _emailController,
            isEmail: true,
            hint: 'Example@123.com',
            label: 'Email',
            validator: (val) {
              final pattern = new RegExp(r'([\d\w]{1,}@[\w\d]{1,}\.[\w]{1,})');
              if (val != null)
                return pattern.hasMatch(val) ? null : 'email is invalid';
            },
          ),
          CustomTextFormField(
            context: context,
            label: 'Password',
            hint: 'password',
            controller: _passwordController,
            isObscureText: _isObscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _isObscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
              onPressed: () {
                setState(() {
                  _isObscurePassword = !_isObscurePassword;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _handleBackLogin() {
    return SizedBox(
      height: 50,
      width: double.maxFinite,
      child: Align(
        alignment: Alignment.center,
        child: TextButton(
          onPressed: () => Navigator.pop(context),
          child: RichText(
            text: TextSpan(
                text: 'Sudah punya akun? ',
                style: TextStyle(color: Colors.black45),
                children: [
                  TextSpan(
                    text: 'Login',
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  void _handleRegister() async {
    final _email = _emailController.value;
    final _password = _passwordController.value;
    final _username = _usernameController.value;
    if (formKey.currentState?.validate() == true &&
        _email != null &&
        _password != null &&
        _username != null) {
      print(_emailController.value);
      User user = User(
        userName: _username,
        email: _email,
        password: _password,
      );
      context.read<AuthBlocCubit>().register(user);
    }
  }
}
