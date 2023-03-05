import 'dart:async';

import 'package:firebase_sdk/trackers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_module.dart';
import 'app_widget.dart';
import 'firebase_options.dart';

void main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await FirebaseSDK.initialize(
        name: 'biblioteca-app-621b2',
        options: DefaultFirebaseOptions.currentPlatform,
      );

      FlutterError.onError = FirebaseSDK.recordCrashlyticsFlutterFatalError;
      final app = ModularApp(module: AppModule(), child: const AppWidget());

      runApp(app);
      Modular.setInitialRoute(Modular.initialRoute);
    },
    (error, stack) {
      FirebaseSDK.recordCrashlyticsError(error, stack, true);
    },
  );
}
