import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_app/common/helper/navigation/app_navigation.dart';
import 'package:my_app/common/widgets/isw_button.dart';
import 'package:my_app/core/configs/theme/app_colors.dart';
import 'package:my_app/core/routes/routes.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SignUpPage extends HookConsumerWidget {
  SignUpPage({super.key});
  final formKey = GlobalKey<FormState>();
  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) return 'Email is required';
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(email)) return 'Enter a valid email';
    return null;
  }

  String? validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'Phone number is required';
    } else if (phone.length != 11) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    } else if (password.length < 8 ||
        !password.contains(RegExp(r'[A-Z]')) ||
        !password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain: 8+ characters\n1 uppercase letter\n1 special character';
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useMemoized(() => TextEditingController());
    final passwordController = useMemoized(() => TextEditingController());
    final phoneNumberController = useMemoized(() => TextEditingController());

    final emailFocusNode = useFocusNode();

    final emailTouched = useState(false);
    final passwordTouched = useState(false);
    final phoneTouched = useState(false);

    final isValid = useState(false);

    void validate() {
      final email = emailController.text;
      final password = passwordController.text;
      final phone = phoneNumberController.text;

      bool emailValid = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      ).hasMatch(email);
      bool passwordValid =
          password.length >= 8 &&
          password.contains(RegExp(r'[A-Z]')) &&
          password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      bool phoneValid = phone.length == 11;

      isValid.value = emailValid && passwordValid && phoneValid;
    }

    useEffect(() {
      emailController.addListener(validate);
      passwordController.addListener(validate);
      phoneNumberController.addListener(validate);

      // Initial validation
      validate();

      return () {
        emailController.removeListener(validate);
        passwordController.removeListener(validate);
        phoneNumberController.removeListener(validate);
      };
    }, [emailController, passwordController, phoneNumberController]);

    final Shader linearGradient = LinearGradient(
      colors: <Color>[
        AppColors.iswBlue,
        AppColors.iswPinkishRed,
        AppColors.iswBlue,
      ],
    ).createShader(Rect.fromLTWH(100.0, 0.0, 500.0, 80.0));

    void submit() {
      if (formKey.currentState!.validate()) {
        print('Logging in with ${emailController.text}');
        // Perform your submission logic here
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        minimum: EdgeInsets.only(top: 100, right: 16, left: 16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
            return Column(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  height: keyboardOpen ? 0 : 168,
                  decoration: BoxDecoration(
                    color: AppColors.iswPlaceHolderGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      child: Form(
                        key: formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            _emailField(
                              context,
                              emailController,
                              emailTouched,
                              emailFocusNode,
                            ),
                            SizedBox(height: 20),
                            _phoneNumberField(
                              context,
                              phoneNumberController,
                              phoneTouched,
                            ),
                            SizedBox(height: 20),
                            _passwordField(passwordController, passwordTouched),
                            SizedBox(height: 20),
                            IswButton(
                              label: "Register",
                              onPressed:
                                  !isValid.value
                                      ? null
                                      : () {
                                        emailTouched.value = true;
                                        phoneTouched.value = true;
                                        passwordTouched.value = true;
                                        submit();
                                      },
                              isValid:
                                  isValid
                                      .value, // always active, validation inside
                            ),
                            SizedBox(height: 10),
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

  Widget _emailField(
    BuildContext context,
    TextEditingController controller,
    ValueNotifier<bool> touched,
    FocusNode? focusNode,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Email', textAlign: TextAlign.left),
        TextFormField(
          controller: controller,
          autovalidateMode: AutovalidateMode.always,
          keyboardType: TextInputType.emailAddress,
          cursorColor: AppColors.iswBlue,
          onChanged: (_) => touched.value = true,
          validator: (value) {
            if (!touched.value) return null;
            return validateEmail(value);
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _phoneNumberField(
    BuildContext context,
    TextEditingController controller,
    ValueNotifier<bool> touched,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Phone number', textAlign: TextAlign.left),
        TextFormField(
          autovalidateMode: AutovalidateMode.always,
          keyboardType: TextInputType.number,
          controller: controller,
          onChanged: (_) => touched.value = true,
          cursorColor: Theme.of(context).primaryColor,
          validator: (value) {
            if (!touched.value) return null;
            return validatePhone(value);
          },
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(11),
          ],
        ),
      ],
    );
  }

  Widget _passwordField(
    TextEditingController controller,
    ValueNotifier<bool> touched,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Password', textAlign: TextAlign.left),
        TextFormField(
          autovalidateMode: AutovalidateMode.always,
          controller: controller,
          obscureText: true,
          decoration: InputDecoration(
            errorMaxLines: 3,
            errorStyle: TextStyle(overflow: TextOverflow.visible),
          ),
          onChanged: (_) => touched.value = true,
          validator: (value) {
            if (!touched.value) return null;
            return validatePassword(value);
          },
        ),
      ],
    );
  }

  Widget _signupText(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "Have an account? ",
        style: TextStyle(color: AppColors.secondBackground),
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
          TextSpan(text: "Get your "),
          TextSpan(
            text: "Interswitch Credit Card ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              foreground: Paint()..shader = linearGradient,
            ),
          ),
          TextSpan(text: "Register to get started"),
        ],
      ),
    );
  }
}
