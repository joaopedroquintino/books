import '../../../login/data/dto/authentication_dto.dart';

abstract class AuthenticationDatasource {
  Future<bool> saveAuthentication(AuthenticationDTO dto);
  Future<AuthenticationDTO?> getAuthentication();
  Future<bool> deleteAuthentication();
}
