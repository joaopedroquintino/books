import 'package:bloc_test/bloc_test.dart';
import 'package:books/modules/login/domain/entities/login_entity.dart';
import 'package:books/modules/login/domain/usecases/login_usecase.dart';
import 'package:books/modules/login/presentation/cubits/login_cubit.dart';
import 'package:books/shared/errors/app_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockSignInUseCase extends Mock implements LoginUseCase {}

void main() {
  late LoginCubit _cubit;
  late MockSignInUseCase loginUseCase;

  setUp(() {
    loginUseCase = MockSignInUseCase();
    _cubit = LoginCubit(loginUseCase: loginUseCase);
  });

  group('LoginCubit', () {
    const tEmail = 'joaoquintino@ioasys.com';
    const tPassword = 'tPassword1';
    const tLoginEntity = LoginEntity(
      email: tEmail,
      password: tPassword,
    );
    const tError = AppFailure(message: 'Erro ao logar');

    test('verify initial state', () {
      expect(_cubit.state, LoginInitialState());
    });
    blocTest<LoginCubit, LoginState>(
      'should emit [LoginLoadingState, LoginSuccessState] when login called',
      build: () {
        when(() => loginUseCase.call(tLoginEntity))
            .thenAnswer((_) async => const Right(unit));

        _cubit.email = tEmail;
        _cubit.password = tPassword;
        return _cubit;
      },
      act: (cubit) => cubit.authenticate(),
      verify: (cubit) {
        verify(() => loginUseCase.call(tLoginEntity));
        verifyNoMoreInteractions(loginUseCase);
      },
      expect: () => <LoginState>[LoginLoadingState(), LoginSuccessState()],
    );

    blocTest<LoginCubit, LoginState>(
      'should emit [LoginLoadingState, LogonErrorState] when login called',
      build: () {
        when(() => loginUseCase.call(tLoginEntity))
            .thenAnswer((_) async => const Left(tError));

        _cubit.email = tEmail;
        _cubit.password = tPassword;
        return _cubit;
      },
      act: (cubit) => cubit.authenticate(),
      verify: (cubit) {
        verify(() => loginUseCase.call(tLoginEntity));
        verifyNoMoreInteractions(loginUseCase);
      },
      expect: () => <LoginState>[
        LoginLoadingState(),
        LoginErrorState(passwordError: tError.message)
      ],
    );
  });

  tearDownAll(() {
    _cubit.close();
  });
}
