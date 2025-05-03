import 'package:dartz/dartz.dart';
import 'package:my_app/data/models/auth/signin_req_param%20copy.dart';
import 'package:my_app/data/models/auth/signup_req_param.dart';

abstract class AuthenticationRepository {
  Future<Either> signup(SignupReqParam params);
  Future<Either> signin(SigninReqParam params);
}
