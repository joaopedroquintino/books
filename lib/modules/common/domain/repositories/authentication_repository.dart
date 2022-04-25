import 'package:dartz/dartz.dart';

import '../../../../shared/errors/app_failure.dart';
import '../entities/authentication_entity.dart';

abstract class AuthenticationRepository {
  Future<Either<AppFailure, AuthenticationEntity>> getAuthentication();
  Future<Either<AppFailure, bool>> removeAuthentication();
  Future<Either<AppFailure, bool>> saveAuthentication(
    AuthenticationEntity authenticationEntity,
  );
}
