import 'package:equatable/equatable.dart';

class AuthenticationEntity extends Equatable {
  const AuthenticationEntity({
    required this.authorization,
    required this.refreshToken,
  });

  final String authorization;
  final String refreshToken;

  @override
  List<Object?> get props => [
        authorization,
        refreshToken,
      ];
}
