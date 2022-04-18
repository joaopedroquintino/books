import 'package:flutter_modular/flutter_modular.dart';

import '../home/home_module.dart';
import '../login/login_module.dart';
import '../splash/splash_module.dart';

class AppRouting {
  AppRouting();

  static List<ModularRoute> get routes {
    return <ModularRoute>[
      ModuleRoute<void>(
        AppRouteNamed.splash._path,
        module: SplashModule(),
      ),
      ModuleRoute<void>(
        AppRouteNamed.login._path,
        module: LoginModule(),
      ),
      ModuleRoute<void>(
        AppRouteNamed.home._path,
        module: HomeModule(),
      ),
    ];
  }
}

enum AppRouteNamed {
  splash,
  login,
  home,
}

extension AppRouteNamedExtension on AppRouteNamed {
  String get _path {
    switch (this) {
      case AppRouteNamed.splash:
        return '/splash-screen';

      case AppRouteNamed.login:
        return '/login';
      case AppRouteNamed.home:
        return '/home';
      default:
        return '/';
    }
  }

  String get fullPath => _path;
}
