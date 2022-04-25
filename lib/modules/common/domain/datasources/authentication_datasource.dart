import '../../data/models/authentication_model.dart';

abstract class AuthenticationDatasource {
  Future<bool> saveAuthentication(AuthenticationModel dto);
  Future<AuthenticationModel?> getAuthentication();
  Future<bool> deleteAuthentication();
}
