import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../shared/errors/app_failure.dart';
import '../entities/authentication_entity.dart';
import '../repositories/authentication_repository.dart';

class RefreshTokenUseCase extends UseCase<AuthenticationEntity, dynamic> {
  RefreshTokenUseCase({
    required this.authenticationRepository,
  });

  final AuthenticationRepository authenticationRepository;

  @override
  Future<Either<AppFailure, AuthenticationEntity>> call([params]) async {
    return authenticationRepository.refreshToken();
  }
}
