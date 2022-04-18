import 'package:flutter_modular/flutter_modular.dart';

import '../app/app_routing.dart';
import 'presentation/cubits/login_cubit.dart';
import 'presentation/login_page.dart';

class LoginRouting {
  LoginRouting();

  static final List<ModularRoute> routes = <ModularRoute>[
    ChildRoute<void>(
      LoginRouteNamed.login._path,
      child: (_, args) => LoginPage(
        cubit: Modular.get<LoginCubit>(),
      ),
    )
  ];
}

enum LoginRouteNamed {
  login,
}

extension LoginRouteNamedExtension on LoginRouteNamed {
  String get _path {
    switch (this) {
      case LoginRouteNamed.login:
        return '/';
      default:
        return '/';
    }
  }

  String get fullPath => AppRouteNamed.login.fullPath + _path;
}
