import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/common/helper/navigation/app_navigation.dart';
import 'package:my_app/core/configs/assets/app_images.dart';
import 'package:my_app/core/routes/routes.dart';
import 'package:my_app/presentation/%20bloc/splash_cubit.dart';
import 'package:my_app/presentation/%20bloc/splash_state.dart';
import 'package:my_app/presentation/auth/pages/sign_in.dart';
import 'package:my_app/presentation/auth/pages/walkthrough.dart';
import 'package:my_app/presentation/home/pages/home.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listener:
            (context, state) => {
              AppNavigator.pushNamed(context, Routes.walkthrough),
            },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.splashBackground),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff1A1B20).withOpacity(0), Color(0xff1A1B20)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
