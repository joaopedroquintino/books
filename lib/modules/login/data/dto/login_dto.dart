class LoginDTO {
  LoginDTO({
    this.username,
    this.password,
  });

  factory LoginDTO.fromJson(Map<String, dynamic> json) {
    return LoginDTO(
      username: json['username'] as String,
      password: json['password'] as String,
    );
  }

  final String? username;
  final String? password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = username;
    map['password'] = password;

    return map;
  }
}
