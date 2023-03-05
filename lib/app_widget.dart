import 'package:biblioteca/modules/menu/localizations/menu_localizations_delegate.dart';
import 'package:biblioteca_books_module/biblioteca_books_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      themeMode: ThemeMode.light,
      localizationsDelegates: const [
        MenuModuleLocalizationsDelegate(),
        BooksModuleLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'en_US')],
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 36, 38, 39),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.amber,
          accentColor: const Color.fromARGB(255, 96, 96, 96),
        ),
      ),
    );
  }
}
