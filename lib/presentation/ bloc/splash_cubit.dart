import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/domain/auth/usecases/is_signed_in.dart';
import 'package:my_app/presentation/%20bloc/splash_state.dart';
import 'package:my_app/service_locator.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(DisplaySplash());

  void appStarted() async {
    await Future.delayed(Duration(seconds: 2));
    var isSignedIn = await sl<IsSignedInUseCase>().call(null);
    if (isSignedIn) {
      emit(Authenticated());
    } else {
      emit(UnAuthenticated());
    }
  }
}
