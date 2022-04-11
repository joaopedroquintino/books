import 'package:flutter_modular/flutter_modular.dart';

import 'splash_routing.dart';

class SplashModule extends Module {
  @override
  List<Bind> get binds => <Bind>[];

  @override
  List<ModularRoute> get routes => SplashRouting.routes;
}
