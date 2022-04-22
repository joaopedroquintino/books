import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../shared/errors/app_failure.dart';
import '../repositories/authentication_repository.dart';

class RemoveAuthenticationUseCase extends UseCase<bool, dynamic> {
  RemoveAuthenticationUseCase({
    required this.authenticationRepository,
  });

  final AuthenticationRepository authenticationRepository;

  @override
  Future<Either<AppFailure, bool>> call([params]) async {
    return authenticationRepository.removeAuthentication();
  }
}
