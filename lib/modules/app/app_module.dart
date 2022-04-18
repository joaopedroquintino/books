import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/api/dio/http_dio.dart';
import '../../core/api/factories/dio_factory.dart';
import '../../core/local_storage/local_storage_imp.dart';
import '../../core/local_storage/secure_storage_imp.dart';
import '../common/data/datasources/authentication_datasource.dart';
import '../common/data/repositories/authentication_repository.dart';
import '../common/domain/repositories/authentication_datasource.dart';
import '../common/domain/usecases/get_authentication_usecase.dart';
import '../common/domain/usecases/remove_authentication_usecase.dart';
import '../login/domain/repositories/authentication_repository.dart';
import 'app_routing.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => <Bind>[
        Bind.singleton<Dio>(
          (i) => DioFactory.instance(
            getAuthenticationUseCase: i.get<GetAuthenticationUseCase>(),
            removeAuthenticationUseCase: i.get<RemoveAuthenticationUseCase>(),
          ),
        ),
        Bind.singleton<HttpDio>(
          (i) => HttpDio(
            dio: i.get(),
          ),
        ),
        Bind.singleton<SecureStorageImp>(
          (i) => SecureStorageImp(),
        ),
        Bind.singleton<LocalStorageImpDao>(
          (i) => LocalStorageImpDao(),
        ),
        Bind.singleton<AuthenticationDatasource>(
          (i) => AuthenticationDatasourceImpl(
            secureLocalStorage: i.get<SecureStorageImp>(),
            localStorage: i.get<LocalStorageImpDao>(),
          ),
        ),
        Bind.singleton<AuthenticationRepository>(
          (i) => AuthenticationRepositoryImpl(
            authenticationDatasource: i.get(),
          ),
        ),
        Bind.singleton<GetAuthenticationUseCase>(
          (i) => GetAuthenticationUseCase(
            authenticationRepository: i.get(),
          ),
        ),
        Bind.singleton<RemoveAuthenticationUseCase>(
          (i) => RemoveAuthenticationUseCase(
            authenticationRepository: i.get(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => AppRouting.routes;
}
