import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/domain/usecases/usecase.dart';
import '../../../../common/domain/entities/authentication_entity.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({
    required this.getAuthenticationUseCase,
  }) : super(SplashLoadingState()) {
    verifyUserAuthentication();
  }

  final UseCase<AuthenticationEntity?, dynamic> getAuthenticationUseCase;

  Future<void> verifyUserAuthentication() async {
    try {
      final result = await getAuthenticationUseCase();
      if (result != null) {
        emit(SplashReadyState(loggedIn: true));
      } else {
        emit(SplashReadyState(loggedIn: false));
      }
    } catch (e) {
      emit(SplashReadyState(loggedIn: false));
    }
  }
}
