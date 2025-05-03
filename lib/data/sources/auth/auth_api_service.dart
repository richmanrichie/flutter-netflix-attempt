import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:my_app/core/constants/api_url.dart';
import 'package:my_app/core/network/dio_client.dart';
import 'package:my_app/data/models/auth/signin_req_param%20copy.dart';
import 'package:my_app/data/models/auth/signup_req_param.dart';
import 'package:my_app/service_locator.dart';

abstract class AuthApiService {
  Future<Either> signup(SignupReqParam params);
  Future<Either> signin(SigninReqParam params);
}

class AuthApiServiceImpl extends AuthApiService {
  @override
  Future<Either> signup(SignupReqParam params) async {
    try {
      var response = await sl<DioClient>().post(
        ApiUrl.signup,
        data: params.toMap(),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> signin(SigninReqParam params) async {
    try {
      var response = await sl<DioClient>().post(
        ApiUrl.signin,
        data: params.toMap(),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }
}
