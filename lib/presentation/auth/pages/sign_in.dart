import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_app/common/helper/navigation/app_navigation.dart';
import 'package:my_app/common/widgets/isw_button.dart';
import 'package:my_app/core/configs/theme/app_colors.dart';
import 'package:my_app/core/routes/routes.dart';
import 'package:my_app/presentation/auth/pages/sign_up.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SignInPage extends HookConsumerWidget {
  SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _emailController = useTextEditingController();
    final _passwordController = useTextEditingController();
    final isValid = useState(false);

    useEffect(() {
      void listener() {
        isValid.value =
            _emailController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty;
      }

      _emailController.addListener(listener);
      _passwordController.addListener(listener);

      return () {
        _emailController.removeListener(listener);
        _passwordController.removeListener(listener);
      };
    }, [_emailController, _passwordController]);

    void submit() {
      if (isValid.value) {
        print('Logging in with ${_emailController.text}');
      }
    }

    final Shader linearGradient = LinearGradient(
      colors: <Color>[
        AppColors.iswBlue,
        AppColors.iswPinkishRed,
        AppColors.iswBlue,
      ],
    ).createShader(Rect.fromLTWH(100.0, 0.0, 500.0, 80.0));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        minimum: EdgeInsets.only(top: 100, right: 16, left: 16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  height: keyboardOpen ? 0 : 200, // Adjust the height as needed
                  decoration: BoxDecoration(
                    color: AppColors.iswPlaceHolderGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: _regMessage(linearGradient: linearGradient),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
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
                            _emailField(controller: _emailController),
                            SizedBox(height: 20),
                            _passwordField(controller: _passwordController),
                            SizedBox(height: 20),
                            IswButton(
                              label: "Sign In",
                              onPressed: isValid.value ? submit : null,
                              isValid: isValid.value,
                            ),
                            SizedBox(height: 10),
                            IswButton(
                              label: "Use Finger Print",
                              isInverted: true,
                              isValid: true,
                              onPressed: () {},
                            ),
                            SizedBox(height: 20),
                            _signupText(context),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _emailField({required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Email or Phone', textAlign: TextAlign.left),
        TextFormField(controller: controller, onChanged: (_) {}),
      ],
    );
  }

  Widget _forgotPassword() {
    return RichText(
      text: TextSpan(
        text: "Forgot Password?",
        children: [
          TextSpan(
            text: 'Reset',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.secondBackground,
            ),
          ),
        ],
      ),
    );
  }

  Widget _passwordField({required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Password', textAlign: TextAlign.left),
        TextField(controller: controller, onChanged: (_) {}, obscureText: true),
      ],
    );
  }

  Widget _signupText(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "New here? ",
        style: TextStyle(color: AppColors.secondBackground),
        children: <TextSpan>[
          TextSpan(
            text: 'Register',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    AppNavigator.pushNamed(context, Routes.register);
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
