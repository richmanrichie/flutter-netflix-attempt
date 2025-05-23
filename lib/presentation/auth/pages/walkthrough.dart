import 'package:flutter/material.dart';
import 'package:my_app/common/helper/navigation/app_navigation.dart';
import 'package:my_app/common/widgets/isw_button.dart';
import 'package:my_app/core/configs/theme/app_colors.dart';
import 'package:my_app/core/routes/routes.dart';

class WalkThroughPage extends StatelessWidget {
  const WalkThroughPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Expanded(child: SafeArea(child: _imageBox())),
            SizedBox(height: 20),
            _buttonContainer(context),
          ],
        ),
      ),
    );
  }

  Widget _imageBox() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        width: double.infinity,
        child: Center(
          child: Text(
            'Big Box',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
    );
  }

  Widget _buttonContainer(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 70),
        child: Row(
          children: [
            Expanded(
              child: IswButton(
                label: "Register",
                isInverted: true,
                onPressed:
                    () => {AppNavigator.pushNamed(context, Routes.register)},
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: IswButton(
                label: "Sign In",
                onPressed:
                    () => {AppNavigator.pushNamed(context, Routes.signin)},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
