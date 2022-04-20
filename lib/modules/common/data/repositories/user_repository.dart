import 'package:dartz/dartz.dart';

import '../../../../packages/data/interface/data_return.dart';
import '../../../../shared/errors/app_failure.dart';
import '../../domain/datasources/user_datasource.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({
    required UserDataSource userDataSource,
  }) : _datasource = userDataSource;

  final UserDataSource _datasource;

  @override
  Future<Either<AppFailure, UserEntity>> fetchUser() async {
    try {
      final result = await _datasource.getUser();
      if (result is DataSuccess) {
        return Right(UserModel.fromJson(result.body as Map<String, dynamic>));
      } else {
        return Left(AppFailure(message: result.message));
      }
    } catch (e) {
      return const Left(
          AppFailure(message: 'UserRepository fetchUser decode error'));
    }
  }
}
