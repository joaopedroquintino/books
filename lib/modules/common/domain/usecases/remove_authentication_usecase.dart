import '../../../../core/domain/usecases/usecase.dart';
import '../../../login/domain/repositories/authentication_repository.dart';

class RemoveAuthenticationUseCase extends UseCase<bool?, dynamic> {
  RemoveAuthenticationUseCase({
    required this.authenticationRepository,
  });

  final AuthenticationRepository authenticationRepository;

  @override
  Future<bool?> call([params]) async {
    return authenticationRepository.removeAuthentication();
  }
}
