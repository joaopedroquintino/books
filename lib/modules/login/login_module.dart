import 'package:flutter_modular/flutter_modular.dart';

import '../../core/local_storage/local_storage_imp.dart';
import '../../core/local_storage/secure_storage_imp.dart';
import '../common/data/datasources/authentication_datasource.dart';
import 'data/datasources/login_datasource.dart';
import 'data/repositories/login_repository.dart';
import 'domain/usecases/login_usecase.dart';
import 'login_routing.dart';
import 'presentation/cubits/login_cubit.dart';

class LoginModule extends Module {
  @override
  List<Bind> get binds => <Bind>[
        Bind.singleton(
          (i) => AuthenticationDatasourceImpl(
            secureLocalStorage: i.get<SecureStorageImp>(),
            localStorage: i.get<LocalStorageImpDao>(),
          ),
        ),
        Bind.singleton(
          (i) => LoginDatasourceImpl(
            http: i.get(),
          ),
        ),
        Bind.singleton(
          (i) => LoginRepositoryImpl(
            loginDatasource: i.get(),
            authenticationDatasource: i.get(),
          ),
        ),
        Bind.singleton(
          (i) => LoginUseCase(
            loginRepository: i.get(),
          ),
        ),
        Bind.factory(
          (i) => LoginCubit(
            loginUseCase: i.get<LoginUseCase>(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => LoginRouting.routes;
}
