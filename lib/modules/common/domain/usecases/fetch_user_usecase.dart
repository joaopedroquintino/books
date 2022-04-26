import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../shared/errors/app_failure.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class FetchUserUseCase extends UseCase<UserEntity, dynamic> {
  FetchUserUseCase({
    required UserRepository userRepository,
  }) : _repo = userRepository;

  final UserRepository _repo;

  @override
  Future<Either<AppFailure, UserEntity>> call([params]) async {
    return _repo.fetchUser();
  }
}
