import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/configs/theme/app_theme.dart';
import 'package:my_app/core/routes/route_generator.dart';
import 'package:my_app/core/routes/routes.dart';
import 'package:my_app/presentation/%20bloc/splash_cubit.dart';
import 'package:my_app/presentation/splash/splash.dart';
import 'package:my_app/service_locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    return BlocProvider(
      create: (context) => SplashCubit()..appStarted(),
      child: MaterialApp(
        title: 'Flutter Demo',
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: Routes.splash,
        theme: AppTheme.appTheme,
      ),
    );
  }
}
