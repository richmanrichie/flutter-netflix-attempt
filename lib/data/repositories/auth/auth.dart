import 'package:dartz/dartz.dart';
import 'package:my_app/data/models/auth/signin_req_param%20copy.dart';
import 'package:my_app/data/models/auth/signup_req_param.dart';
import 'package:my_app/data/sources/auth/auth_api_service.dart';
import 'package:my_app/domain/repositories/auth.dart';
import 'package:my_app/service_locator.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  @override
  Future<Either> signup(SignupReqParam params) async {
    return await sl<AuthApiService>().signup(params);
  }

  @override
  Future<Either> signin(SigninReqParam params) async {
    return await sl<AuthApiService>().signin(params);
  }
}
