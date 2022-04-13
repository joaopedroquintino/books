import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../shared/errors/app_failure.dart';
import '../../domain/entities/login_entity.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required this.loginUseCase,
  }) : super(LoginInitialState());

  final UseCase<Either<AppFailure, Unit>, LoginEntity> loginUseCase;

  String? email;
  String? password;

  Future<void> authenticate() async {
    if (!isEmailValid) {
      emit(LoginErrorState(emailError: 'E-mail inválido.'));
      return;
    }
    if (!isPasswordValid) {
      emit(LoginErrorState(passwordError: 'Senha inválida.'));
      return;
    }
    final loginParams = LoginEntity(email: email!, password: password!);
    emit(LoginLoadingState());

    final result = await loginUseCase.call(loginParams);

    result.fold(
      (failure) => emit(
        LoginErrorState(passwordError: failure.message),
      ),
      (_) => emit(LoginSuccessState()),
    );
  }

  bool get isEmailValid {
    if (email == null) {
      return false;
    }
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(
      email!,
    );
  }

  bool get isPasswordValid {
    return password != null && password!.length > 4;
  }
}
