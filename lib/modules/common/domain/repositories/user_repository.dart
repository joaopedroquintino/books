import 'package:dartz/dartz.dart';

import '../../../../shared/errors/app_failure.dart';
import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<AppFailure, UserEntity>> fetchUser();
}
