import 'package:dartz/dartz.dart';

import '../../../../shared/errors/app_failure.dart';
import '../../domain/datasources/authentication_datasource.dart';
import '../../domain/entities/authentication_entity.dart';
import '../../domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl({
    required this.authenticationDatasource,
  });

  final AuthenticationDatasource authenticationDatasource;

  @override
  Future<Either<AppFailure, AuthenticationEntity>> getAuthentication() async {
    try {
      final result = await authenticationDatasource.getAuthentication();
      if (result != null) {
        return Right(AuthenticationEntity(
          authorization: result.authorization,
          refreshToken: result.refreshToken,
        ));
      } else {
        return const Left(AppFailure());
      }
    } catch (e) {
      return const Left(AppFailure());
    }
  }

  @override
  Future<Either<AppFailure, bool>> removeAuthentication() async {
    try {
      final result = await authenticationDatasource.deleteAuthentication();
      return Right(result);
    } catch (e) {
      return const Left(AppFailure());
    }
  }
}
