class AuthenticationDTO {
  AuthenticationDTO({
    required this.authorization,
    required this.refreshToken,
  });

  factory AuthenticationDTO.fromJson(Map<String, dynamic> json) {
    return AuthenticationDTO(
      authorization: json['authorization'] as String,
      refreshToken: json['refresh-token'] as String,
    );
  }

  final String authorization;
  final String refreshToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['authorization'] = authorization;
    map['refresh-token'] = refreshToken;

    return map;
  }
}
