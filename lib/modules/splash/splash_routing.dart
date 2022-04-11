import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../app/app_routing.dart';

class SplashRouting {
  SplashRouting();

  static final List<ModularRoute> routes = <ModularRoute>[
    ChildRoute<void>(
      SplashRouteNamed.splash._path,
      child: (_, args) => const Scaffold(),
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
