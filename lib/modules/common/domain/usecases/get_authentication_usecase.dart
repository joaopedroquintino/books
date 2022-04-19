import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../shared/errors/app_failure.dart';
import '../repositories/authentication_repository.dart';
import '../entities/authentication_entity.dart';

class GetAuthenticationUseCase extends UseCase<AuthenticationEntity, dynamic> {
  GetAuthenticationUseCase({
    required this.authenticationRepository,
  });

  final AuthenticationRepository authenticationRepository;

  @override
  Future<Either<AppFailure, AuthenticationEntity>> call([params]) async {
    return authenticationRepository.getAuthentication();
  }
}
