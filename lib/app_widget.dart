import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Modular.initialRoute,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          accentColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
      ),
    ).modular();
  }
}
