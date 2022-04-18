import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.name,
    required this.birthDate,
    required this.gender,
  });
  final String id;
  final String name;
  final String birthDate;
  final String gender;

  @override
  List<Object?> get props => [id, name, birthDate, gender];
}
