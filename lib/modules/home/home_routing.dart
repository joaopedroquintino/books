import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../app/app_routing.dart';
import 'presentation/pages/book_details_page.dart';
import 'presentation/pages/home_page.dart';

class HomeRouting {
  HomeRouting();

  static final List<ModularRoute> routes = <ModularRoute>[
    ChildRoute<void>(
      HomeRouteNamed.home._path,
      child: (_, args) => const HomePage(),
    ),
    ChildRoute<void>(
      HomeRouteNamed.bookDetails._path,
      child: (_, args) => BookDetailsPage(id: args.data as String),
      transition: TransitionType.downToUp,
    ),
  ];
}

enum HomeRouteNamed {
  home,
  bookDetails,
}

extension HomeRouteNamedExtension on HomeRouteNamed {
  String get _path {
    switch (this) {
      case HomeRouteNamed.home:
        return '/';
      case HomeRouteNamed.bookDetails:
        return '/book-details';
      default:
        return '/';
    }
  }

  String get fullPath => AppRouteNamed.home.fullPath + _path;
}
