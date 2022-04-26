import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/api/dio/http_dio.dart';
import '../../core/api/factories/dio_factory.dart';
import '../../core/local_storage/local_storage_imp.dart';
import '../../core/local_storage/secure_storage_imp.dart';
import '../common/data/datasources/authentication_datasource.dart';
import '../common/data/datasources/user_datasource.dart';
import '../common/data/repositories/authentication_repository.dart';
import '../common/data/repositories/user_repository.dart';
import '../common/domain/datasources/authentication_datasource.dart';
import '../common/domain/datasources/user_datasource.dart';
import '../common/domain/repositories/authentication_repository.dart';
import '../common/domain/repositories/user_repository.dart';
import '../common/domain/usecases/fetch_user_usecase.dart';
import '../common/domain/usecases/get_authentication_usecase.dart';
import '../common/domain/usecases/remove_authentication_usecase.dart';
import '../common/domain/usecases/save_authentication_usecase.dart';
import 'app_routing.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => <Bind>[
        Bind.lazySingleton<Dio>(
          (i) => DioFactory.instance(
            getAuthenticationUseCase: i.get<GetAuthenticationUseCase>(),
            removeAuthenticationUseCase: i.get<RemoveAuthenticationUseCase>(),
            saveAuthentication: i.get<SaveAuthenticationUseCase>(),
          ),
        ),
        Bind.lazySingleton<HttpDio>(
          (i) => HttpDio(
            dio: i.get(),
          ),
        ),
        Bind.lazySingleton<SecureStorageImp>(
          (i) => SecureStorageImp(),
        ),
        Bind.lazySingleton<LocalStorageImpDao>(
          (i) => LocalStorageImpDao(),
        ),
        Bind.lazySingleton<AuthenticationDatasource>(
          (i) => AuthenticationDatasourceImpl(
            secureLocalStorage: i.get<SecureStorageImp>(),
            localStorage: i.get<LocalStorageImpDao>(),
          ),
        ),
        Bind.lazySingleton<UserDataSource>(
          (i) => UserDataSourceImpl(
            database: i.get<LocalStorageImpDao>(),
          ),
        ),
        Bind.lazySingleton<AuthenticationRepository>(
          (i) => AuthenticationRepositoryImpl(
            authenticationDatasource: i.get(),
          ),
        ),
        Bind.lazySingleton<UserRepository>(
          (i) => UserRepositoryImpl(
            userDataSource: i.get(),
          ),
        ),
        Bind.lazySingleton<GetAuthenticationUseCase>(
          (i) => GetAuthenticationUseCase(
            authenticationRepository: i.get(),
          ),
        ),
        Bind.lazySingleton<RemoveAuthenticationUseCase>(
          (i) => RemoveAuthenticationUseCase(
            authenticationRepository: i.get(),
          ),
        ),
        Bind.lazySingleton<SaveAuthenticationUseCase>(
          (i) => SaveAuthenticationUseCase(
            authenticationRepository: i.get(),
          ),
        ),
        Bind.lazySingleton(
          (i) => FetchUserUseCase(
            userRepository: i.get(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => AppRouting.routes;
}
