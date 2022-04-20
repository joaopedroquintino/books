import 'package:flutter_modular/flutter_modular.dart';

import '../../../packages/ds/app_system.dart';
import '../../splash/splash_routing.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({
    Key? key,
  }) : super(key: key);

  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute(SplashRouteNamed.splash.fullPath);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        locale: const Locale('pt-BR'),
        routerDelegate: Modular.routerDelegate,
        routeInformationParser: Modular.routeInformationParser,
        theme: ThemeData(fontFamily: 'Heebo'),
      ),
    );
  }
}
