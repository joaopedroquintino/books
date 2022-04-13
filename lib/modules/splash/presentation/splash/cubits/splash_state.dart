part of 'splash_cubit.dart';

abstract class SplashState {}

class SplashLoadingState extends SplashState {}

class SplashReadyState extends SplashState {
  SplashReadyState({
    required this.loggedIn,
  });

  final bool loggedIn;
}
