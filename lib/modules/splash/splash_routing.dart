import 'package:flutter_modular/flutter_modular.dart';

import '../app/app_routing.dart';
import 'presentation/splash/cubits/splash_cubit.dart';
import 'presentation/splash/splash_page.dart';

class SplashRouting {
  SplashRouting();

  static final List<ModularRoute> routes = <ModularRoute>[
    ChildRoute<void>(
      SplashRouteNamed.splash._path,
      child: (_, args) => SplashPage(
        cubit: Modular.get<SplashCubit>(),
      ),
    )
  ];
}

enum SplashRouteNamed { splash }

extension SplashRouteNamedExtension on SplashRouteNamed {
  String get _path {
    switch (this) {
      case SplashRouteNamed.splash:
        return '/';
      default:
        return '/';
    }
  }

  String get fullPath => AppRouteNamed.splash.fullPath + _path;
}
