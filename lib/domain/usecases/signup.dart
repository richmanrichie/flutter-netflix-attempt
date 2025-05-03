import 'package:dartz/dartz.dart';
import 'package:my_app/core/usecase/usecase.dart';
import 'package:my_app/data/models/auth/signup_req_param.dart';
import 'package:my_app/domain/repositories/auth.dart';
import 'package:my_app/service_locator.dart';

class SignupUseCase extends UseCase<Either, SignupReqParam> {
  @override
  Future<Either> call(SignupReqParam? params) async {
    return await sl<AuthenticationRepository>().signup(params!);
  }
}
