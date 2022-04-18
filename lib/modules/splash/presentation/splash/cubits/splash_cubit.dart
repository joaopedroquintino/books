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
    final result = await getAuthenticationUseCase();
    result.fold(
      (_) => emit(SplashReadyState(loggedIn: false)),
      (_) => emit(SplashReadyState(loggedIn: true)),
    );
  }
}
