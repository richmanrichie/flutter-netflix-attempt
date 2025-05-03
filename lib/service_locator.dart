import 'package:get_it/get_it.dart';
import 'package:my_app/core/network/dio_client.dart';
import 'package:my_app/data/repositories/auth/auth.dart';
import 'package:my_app/data/sources/auth/auth_api_service.dart';
import 'package:my_app/domain/repositories/auth.dart';
import 'package:my_app/domain/usecases/sign_in.dart';
import 'package:my_app/domain/usecases/signup.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());

  // Services
  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());

  // Repository
  sl.registerSingleton<AuthenticationRepository>(
    AuthenticationRepositoryImpl(),
  );

  //usecases
  sl.registerSingleton<SignupUseCase>(SignupUseCase());
  sl.registerSingleton<SigninUseCase>(SigninUseCase());
}
