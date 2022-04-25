import '../../domain/entities/authentication_entity.dart';

class AuthenticationModel extends AuthenticationEntity {
  const AuthenticationModel({
    required String authorization,
    required String refreshToken,
  }) : super(
          authorization: authorization,
          refreshToken: refreshToken,
        );

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) {
    return AuthenticationModel(
      authorization: json['authorization'] as String,
      refreshToken: json['refresh-token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['authorization'] = authorization;
    map['refresh-token'] = refreshToken;

    return map;
  }
}
