import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/app/app_module.dart';
import 'modules/app/presentation/app_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runZonedGuarded(() async {
    runApp(
      ModularApp(
        module: AppModule(),
        child: const AppWidget(),
      ),
    );
  }, (o, s) {
    debugPrint(o.toString());
    debugPrintStack(stackTrace: s);
  });
}
