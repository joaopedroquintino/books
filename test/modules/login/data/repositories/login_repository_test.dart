import 'package:books/modules/common/data/models/user_model.dart';
import 'package:books/modules/common/domain/datasources/authentication_datasource.dart';
import 'package:books/modules/common/domain/datasources/user_datasource.dart';
import 'package:books/modules/login/data/dto/authentication_dto.dart';
import 'package:books/modules/login/data/dto/login_dto.dart';
import 'package:books/modules/login/data/repositories/login_repository.dart';
import 'package:books/modules/login/domain/datasources/login_datasource.dart';
import 'package:books/modules/login/domain/entities/login_entity.dart';
import 'package:books/modules/login/domain/repositories/login_repository.dart';
import 'package:books/packages/data/interface/data_return.dart';
import 'package:books/shared/errors/app_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginDataSource extends Mock implements LoginDatasource {}

class MockAuthenticationDataSource extends Mock
    implements AuthenticationDatasource {}

class MockUserDataSource extends Mock implements UserDataSource {}

class FakeLoginDTO extends Fake implements LoginDTO {}

class FakeAuthDTO extends Fake implements AuthenticationDTO {}

class FakeUserModel extends Fake implements UserModel {}

Future<void> main() async {
  late MockLoginDataSource loginDatasource;
  late MockAuthenticationDataSource authenticationDatasource;
  late MockUserDataSource userDataSource;
  late LoginRepository repository;

  setUp(() {
    loginDatasource = MockLoginDataSource();
    authenticationDatasource = MockAuthenticationDataSource();
    userDataSource = MockUserDataSource();
    repository = LoginRepositoryImpl(
      loginDatasource: loginDatasource,
      authenticationDatasource: authenticationDatasource,
      userDataSource: userDataSource,
    );

    registerFallbackValue(FakeLoginDTO());
    registerFallbackValue(FakeAuthDTO());
    registerFallbackValue(FakeUserModel());
  });

  const String tAuth = 'iashdahs';
  const String tRefresh = 'aishbaksduhak';
  const headers = {'authorization': tAuth, 'refresh-token': tRefresh};
  const body = {
    'id': '5f41b92c7460b9337660427e',
    'name': 'Henrique da Silva',
    'birthdate': '1990-10-25',
    'gender': 'M'
  };

  void _arrangeSuccessfulLogin() {
    when(() => loginDatasource.authenticate(any())).thenAnswer(
      (_) async => DataSuccess(
        body: body,
        headers: headers,
      ),
    );
    when(() => authenticationDatasource.deleteAuthentication())
        .thenAnswer((_) async => true);
    when(() => authenticationDatasource.saveAuthentication(any()))
        .thenAnswer((_) async => true);
    when(() => userDataSource.setUser(any()))
        .thenAnswer((_) async => DataSuccess(body: {}));
  }

  void _arrangeLoginError() {
    when(() => loginDatasource.authenticate(any())).thenAnswer(
      (_) async => DataError(
        message: 'Ops',
      ),
    );
    when(() => authenticationDatasource.deleteAuthentication())
        .thenAnswer((_) async => true);
    when(() => authenticationDatasource.saveAuthentication(any()))
        .thenAnswer((_) async => true);
    when(() => userDataSource.setUser(any()))
        .thenAnswer((_) async => DataSuccess(body: {}));
  }

  group('LoginDataSource', () {
    const tLoginEntity = LoginEntity(email: 'email', password: 'password');
    const tLoginDTO = LoginDTO(username: 'email', password: 'password');
    test('Success login', () async {
      _arrangeSuccessfulLogin();

      final result = await repository.authenticate(entity: tLoginEntity);

      expect(result, const Right(unit));
      verify(() => loginDatasource.authenticate(tLoginDTO)).called(1);
      verify(() => authenticationDatasource.deleteAuthentication()).called(1);
      verify(() => authenticationDatasource
          .saveAuthentication(AuthenticationDTO.fromJson(headers))).called(1);
      verify(() => userDataSource.setUser(UserModel.fromJson(body)));
    });

    test('Error login', () async {
      _arrangeLoginError();

      final result = await repository.authenticate(entity: tLoginEntity);

      expect(result, const Left(AppFailure(message: 'Ops')));
      verify(() => loginDatasource.authenticate(tLoginDTO)).called(1);
      verifyNever(() => authenticationDatasource.deleteAuthentication());
      verifyNever(() => authenticationDatasource
          .saveAuthentication(AuthenticationDTO.fromJson(headers)));
      verifyNever(() => userDataSource.setUser(UserModel.fromJson(body)));
    });
  });
}
