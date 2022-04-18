import 'package:dartz/dartz.dart';

import '../../../../shared/errors/app_failure.dart';
import '../../../common/domain/entities/authentication_entity.dart';

abstract class AuthenticationRepository {
  Future<Either<AppFailure, AuthenticationEntity>> getAuthentication();
  Future<Either<AppFailure, bool>> removeAuthentication();
}
