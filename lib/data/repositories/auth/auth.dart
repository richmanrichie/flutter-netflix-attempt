import 'package:dartz/dartz.dart';
import 'package:my_app/data/models/auth/signin_req_param%20copy.dart';
import 'package:my_app/data/models/auth/signup_req_param.dart';
import 'package:my_app/data/sources/auth/auth_api_service.dart';
import 'package:my_app/domain/auth/repositories/auth.dart';
import 'package:my_app/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  @override
  Future<Either> signup(SignupReqParam params) async {
    var data = await sl<AuthApiService>().signup(params);
    data.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('token', data['user']['token']);
        return Right(data);
      },
    );
    return data;
  }

  @override
  Future<Either> signin(SigninReqParam params) async {
    var data = await sl<AuthApiService>().signin(params);
    data.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('token', data['user']['token']);
        return Right(data);
      },
    );
    return data;
  }

  @override
  Future<bool> isSignedIn() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    if (token != null) {
      return true;
    } else {
      return false;
    }
  }
}
