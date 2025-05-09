import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_app/common/helper/message/display_message.dart';
import 'package:my_app/common/helper/navigation/app_navigation.dart';
import 'package:my_app/common/widgets/isw_button.dart';
import 'package:my_app/core/configs/theme/app_colors.dart';
import 'package:my_app/data/models/auth/signin_req_param%20copy.dart';
import 'package:my_app/domain/auth/usecases/sign_in.dart';
import 'package:my_app/presentation/auth/pages/sign_up.dart';
import 'package:my_app/presentation/home/pages/home.dart';
import 'package:my_app/service_locator.dart';
import 'package:reactive_button/reactive_button.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Shader linearGradient = LinearGradient(
      colors: <Color>[
        AppColors.iswBlue,
        AppColors.iswPinkishRed,
        AppColors.iswBlue,
      ],
    ).createShader(Rect.fromLTWH(100.0, 0.0, 500.0, 80.0));

    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.only(top: 100, right: 16, left: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.iswPlaceHolderGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: _regMessage(linearGradient: linearGradient),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 60,
                  bottom: 50,
                ),
                child: Column(
                  children: [
                    _emailField(),
                    SizedBox(height: 20),
                    _passwordField(),
                    SizedBox(height: 20),
                    _singinButton(context),
                    Column(
                      children: [IswButton(label: "label", onPressed: () {})],
                    ),
                    SizedBox(height: 20),
                    _signupText(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Email or Phone', textAlign: TextAlign.left),
        TextField(controller: _emailController),
      ],
    );
  }

  Widget _passwordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Password', textAlign: TextAlign.left),
        TextField(controller: _passwordController, obscureText: true),
      ],
    );
  }

  Widget _singinButton(BuildContext context) {
    return ReactiveButton(
      title: 'Sign In',
      activeColor: AppColors.primary,
      onPressed: () async {
        print("i was pressed");
        final params = SigninReqParam(
          email: _emailController.text,
          password: _passwordController.text,
        );
        return await sl<SigninUseCase>().call(params);
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
        text: "Don't have an account? ",
        children: <TextSpan>[
          TextSpan(
            text: 'Sign Up',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    AppNavigator.push(context, SignUpPage());
                  },
          ),
        ],
      ),
    );
  }
}

class _regMessage extends StatelessWidget {
  const _regMessage({super.key, required this.linearGradient});

  final Shader linearGradient;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "",
        style: TextStyle(color: AppColors.secondBackground, fontSize: 24),
        children: [
          TextSpan(text: "Sign into "),
          TextSpan(
            text: "Interswitch Credit",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              foreground: Paint()..shader = linearGradient,
            ),
          ),
        ],
      ),
    );
  }
}
