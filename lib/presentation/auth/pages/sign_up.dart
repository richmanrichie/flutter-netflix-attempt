import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_app/common/helper/message/display_message.dart';
import 'package:my_app/common/helper/navigation/app_navigation.dart';
import 'package:my_app/core/configs/theme/app_colors.dart';
import 'package:my_app/data/models/auth/signup_req_param.dart';
import 'package:my_app/domain/auth/usecases/signup.dart';
import 'package:my_app/presentation/auth/pages/sign_in.dart';
import 'package:my_app/presentation/home/pages/home.dart';
import 'package:my_app/service_locator.dart';
import 'package:reactive_button/reactive_button.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.only(top: 100, right: 16, left: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _signupTitleText(),
            SizedBox(height: 20),
            _emailField(),
            SizedBox(height: 20),
            _passwordField(),
            SizedBox(height: 20),
            _singinButton(context),
            SizedBox(height: 20),
            _signupText(context),
          ],
        ),
      ),
    );
  }

  Widget _signupTitleText() {
    return Text(
      'Sign Up',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
    );
  }

  Widget _emailField() {
    return TextField(
      controller: _emailController,
      decoration: const InputDecoration(hintText: 'Enter Email'),
    );
  }

  Widget _passwordField() {
    return TextField(
      controller: _passwordController,
      obscureText: true,
      decoration: const InputDecoration(hintText: 'Enter Password'),
    );
  }

  Widget _singinButton(BuildContext context) {
    return ReactiveButton(
      title: 'Sign Up',
      activeColor: AppColors.primary,
      onPressed: () async {
        final params = SignupReqParam(
          email: _emailController.text,
          password: _passwordController.text,
        );
        return await sl<SignupUseCase>().call(params);
      },
      onSuccess: () {
        AppNavigator.pushAndRemove(context, HomePage());
      },
      onFailure: (error) {
        print('==========> $error');
        DisplayMessage.errorMessage(error, context);
      },
    );
  }

  Widget _signupText(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "Have an account? ",
        children: <TextSpan>[
          TextSpan(
            text: 'Sign In',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    AppNavigator.push(context, SignInPage());
                  },
          ),
        ],
      ),
    );
  }
}
