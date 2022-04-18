import '../../../common/domain/entities/authentication_entity.dart';

abstract class AuthenticationRepository {
  Future<AuthenticationEntity?> getAuthentication();
  Future<bool?> removeAuthentication();
}
