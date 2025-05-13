import 'package:flutter/material.dart';
import 'package:my_app/core/routes/routes.dart';
import 'package:my_app/presentation/auth/pages/sign_in.dart';
import 'package:my_app/presentation/auth/pages/sign_up.dart';
import 'package:my_app/presentation/auth/pages/walkthrough.dart';
import 'package:my_app/presentation/home/pages/home.dart';
import 'package:my_app/presentation/splash/splash.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case Routes.signin:
        return MaterialPageRoute(builder: (_) => SignInPage());
      case Routes.register:
        return MaterialPageRoute(builder: (_) => SignUpPage());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case Routes.walkthrough:
        return MaterialPageRoute(builder: (_) => const WalkThroughPage());
      default:
        return MaterialPageRoute(builder: (_) => const SplashPage());
    }
  }
}
