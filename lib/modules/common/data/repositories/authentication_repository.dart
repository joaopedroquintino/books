import '../../../login/domain/repositories/authentication_repository.dart';
import '../../domain/entities/authentication_entity.dart';
import '../../domain/repositories/authentication_datasource.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl({
    required this.authenticationDatasource,
  });

  final AuthenticationDatasource authenticationDatasource;

  @override
  Future<AuthenticationEntity?> getAuthentication() async {
    try {
      final result = await authenticationDatasource.getAuthentication();
      if (result != null) {
        return AuthenticationEntity(
          authorization: result.authorization,
          refreshToken: result.refreshToken,
        );
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> removeAuthentication() async {
    try {
      final result = await authenticationDatasource.deleteAuthentication();
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
