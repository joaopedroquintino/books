part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserSuccessState extends UserState {
  const UserSuccessState({required this.user});

  final UserEntity user;

  @override
  List<Object?> get props => [user];
}

class UserErrorState extends UserState {
  const UserErrorState({this.message});

  final String? message;
  @override
  List<Object?> get props => [message];
}
