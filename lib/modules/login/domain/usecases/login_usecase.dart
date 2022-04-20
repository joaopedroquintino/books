import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../shared/errors/app_failure.dart';
import '../entities/login_entity.dart';
import '../repositories/login_repository.dart';

class LoginUseCase extends UseCase<Unit, LoginEntity> {
  LoginUseCase({
    required this.loginRepository,
  });

  final LoginRepository loginRepository;

  @override
  Future<Either<AppFailure, Unit>> call([LoginEntity? params]) async {
    return loginRepository.authenticate(entity: params!);
  }
}
