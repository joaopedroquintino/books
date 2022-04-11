import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/api/dio/http_dio.dart';
import '../../core/api/factories/dio_factory.dart';
import '../../core/local_storage/secure_storage_imp.dart';
import 'app_routing.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => <Bind>[
        Bind.singleton<Dio>(
          (i) => DioFactory.instance(),
        ),
        Bind.singleton<HttpDio>(
          (i) => HttpDio(
            dio: i.get(),
          ),
        ),
        Bind.singleton<SecureStorageImp>(
          (i) => SecureStorageImp(),
        ),
      ];

  @override
  List<ModularRoute> get routes => AppRouting.routes;
}
