part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginErrorState extends LoginState {
  LoginErrorState({
    this.emailError,
    this.passwordError,
  });

  String? emailError;
  String? passwordError;
}
