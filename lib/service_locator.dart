import 'package:get_it/get_it.dart';
import 'package:my_app/core/network/dio_client.dart';
import 'package:my_app/data/repositories/auth/auth.dart';
import 'package:my_app/data/sources/auth/auth_api_service.dart';
import 'package:my_app/domain/auth/repositories/auth.dart';
import 'package:my_app/domain/auth/usecases/is_signed_in.dart';
import 'package:my_app/domain/auth/usecases/sign_in.dart';
import 'package:my_app/domain/auth/usecases/signup.dart';

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
  sl.registerSingleton<IsSignedInUseCase>(IsSignedInUseCase());
}
