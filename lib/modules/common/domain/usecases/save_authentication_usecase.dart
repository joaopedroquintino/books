import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../shared/errors/app_failure.dart';
import '../entities/authentication_entity.dart';
import '../repositories/authentication_repository.dart';

class SaveAuthenticationUseCase extends UseCase<bool, AuthenticationEntity> {
  SaveAuthenticationUseCase({
    required this.authenticationRepository,
  });

  final AuthenticationRepository authenticationRepository;

  @override
  Future<Either<AppFailure, bool>> call([AuthenticationEntity? params]) async {
    return authenticationRepository.saveAuthentication(params!);
  }
}
