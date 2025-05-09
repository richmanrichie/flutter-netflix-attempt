import 'package:my_app/core/usecase/usecase.dart';
import 'package:my_app/domain/auth/repositories/auth.dart';
import 'package:my_app/service_locator.dart';

class IsSignedInUseCase extends UseCase<bool, dynamic> {
  @override
  Future<bool> call(dynamic params) async {
    return await sl<AuthenticationRepository>().isSignedIn();
  }
}
