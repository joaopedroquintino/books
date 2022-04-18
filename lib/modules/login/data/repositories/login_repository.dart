import 'package:dartz/dartz.dart';

import '../../../../packages/data/interface/data_return.dart';
import '../../../../shared/errors/app_failure.dart';
import '../../../common/data/models/user_model.dart';
import '../../../common/domain/repositories/authentication_datasource.dart';
import '../../domain/datasources/login_datasource.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/repositories/login_repository.dart';
import '../dto/authentication_dto.dart';
import '../dto/login_dto.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl({
    required this.loginDatasource,
    required this.authenticationDatasource,
  });

  final LoginDatasource loginDatasource;
  final AuthenticationDatasource authenticationDatasource;

  @override
  Future<Either<AppFailure, Unit>> authenticate({
    required LoginEntity entity,
  }) async {
    try {
      final loginDTO = LoginDTO(
        username: entity.email,
        password: entity.password,
      );
      final result = await loginDatasource.authenticate(loginDTO);
      if (result != null && result is DataSuccess) {
        final authenticationDTO = AuthenticationDTO.fromJson(result.headers!);
        final user = UserModel.fromJson(result.body!);

        await authenticationDatasource.deleteAuthentication();
        await authenticationDatasource.saveAuthentication(authenticationDTO);

        return const Right(unit);
      } else {
        return Left(AppFailure(message: result.message));
      }
    } catch (e) {
      return Left(AppFailure(message: 'Saving Error'));
    }
  }
}
