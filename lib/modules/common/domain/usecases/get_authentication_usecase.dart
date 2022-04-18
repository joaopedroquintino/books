import '../../../../core/domain/usecases/usecase.dart';
import '../entities/authentication_entity.dart';
import '../../../login/domain/repositories/authentication_repository.dart';

class GetAuthenticationUseCase extends UseCase<AuthenticationEntity?, dynamic> {
  GetAuthenticationUseCase({
    required this.authenticationRepository,
  });

  final AuthenticationRepository authenticationRepository;

  @override
  Future<AuthenticationEntity?> call([params]) async {
    return authenticationRepository.getAuthentication();
  }
}
