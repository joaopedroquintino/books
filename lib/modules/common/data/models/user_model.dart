import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String id,
    required String name,
    required String birthDate,
    required String gender,
  }) : super(
          birthDate: birthDate,
          gender: gender,
          id: id,
          name: name,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      birthDate: json['birthdate'] as String,
      gender: json['gender'] as String,
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['birthdate'] = birthDate;
    map['gender'] = gender;

    return map;
  }
}
