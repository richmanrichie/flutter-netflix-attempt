import 'package:dartz/dartz.dart';
import 'package:my_app/core/usecase/usecase.dart';
import 'package:my_app/data/models/auth/signin_req_param%20copy.dart';
import 'package:my_app/domain/auth/repositories/auth.dart';
import 'package:my_app/service_locator.dart';

class SigninUseCase extends UseCase<Either, SigninReqParam> {
  @override
  Future<Either> call(SigninReqParam? params) async {
    Future<Either> answer = sl<AuthenticationRepository>().signin(params!);
    return await answer;
  }
}
