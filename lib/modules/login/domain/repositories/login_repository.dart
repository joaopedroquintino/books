import 'package:dartz/dartz.dart';

import '../../../../shared/errors/app_failure.dart';
import '../entities/login_entity.dart';

abstract class LoginRepository {
  Future<Either<AppFailure, Unit>> authenticate({
    required LoginEntity entity,
  });
}
