part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object?> get props => [];
}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginErrorState extends LoginState {
  const LoginErrorState({
    this.emailError,
    this.passwordError,
  });

  final String? emailError;
  final String? passwordError;

  @override
  List<Object?> get props => [
        emailError,
        passwordError,
      ];
}
