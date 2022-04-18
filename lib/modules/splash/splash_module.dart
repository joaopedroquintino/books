import 'package:flutter_modular/flutter_modular.dart';

import '../common/domain/usecases/get_authentication_usecase.dart';
import 'presentation/splash/cubits/splash_cubit.dart';
import 'splash_routing.dart';

class SplashModule extends Module {
  @override
  List<Bind> get binds => <Bind>[
        Bind.factory<SplashCubit>(
          (i) => SplashCubit(
            getAuthenticationUseCase: i.get<GetAuthenticationUseCase>(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => SplashRouting.routes;
}
