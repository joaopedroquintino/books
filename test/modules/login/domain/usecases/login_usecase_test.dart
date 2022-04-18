import 'package:books/modules/login/domain/entities/login_entity.dart';
import 'package:books/modules/login/domain/repositories/login_repository.dart';
import 'package:books/modules/login/domain/usecases/login_usecase.dart';
import 'package:books/shared/errors/app_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

void main() async {
  late MockLoginRepository _mockRepository;
  late LoginUseCase _usecase;

  setUp(() {
    _mockRepository = MockLoginRepository();
    _usecase = LoginUseCase(
      loginRepository: _mockRepository,
    );
  });

  group('LoginUseCase', () {
    const tEmail = 'test@test.com';
    const tPassword = 'test123';
    const tLoginEntity = LoginEntity(
      email: tEmail,
      password: tPassword,
    );
    const tError = AppFailure(message: 'Erro');
    test(
      'should return an Unit when login with success',
      () async {
        when(() => _mockRepository.authenticate(entity: tLoginEntity))
            .thenAnswer(
          (_) async => const Right(unit),
        );

        final result = await _usecase(tLoginEntity);

        expect(result, const Right(unit));
        verify(() => _mockRepository.authenticate(entity: tLoginEntity))
            .called(1);

        verifyNoMoreInteractions(_mockRepository);
      },
    );

    test('should return an AppFailure when login returns error', () async {
      when(() => _mockRepository.authenticate(entity: tLoginEntity)).thenAnswer(
        (_) async => const Left(tError),
      );

      final result = await _usecase(tLoginEntity);

      expect(result, const Left(tError));
      verify(() => _mockRepository.authenticate(entity: tLoginEntity))
          .called(1);

      verifyNoMoreInteractions(_mockRepository);
    });
  });
}
