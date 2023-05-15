import 'package:biblioteca/app_widget_store.dart';
import 'package:biblioteca/fullscreen_progress.dart';
import 'package:biblioteca/modules/menu/localizations/menu_localizations_delegate.dart';
import 'package:biblioteca_auth_module/biblioteca_auth_module.dart';
import 'package:biblioteca_books_module/biblioteca_books_module.dart';
import 'package:clean_architecture_utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends MainPageState<AppWidget, AppWidgetStore> {
  final key = GlobalKey<ScaffoldMessengerState>();
  @override
  void initState() {
    super.initState();

    store.snackStream.listen((event) {
      key.currentState?.showSnackBar(
        SnackBar(
          content: Text(event.message),
          backgroundColor: event.color,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: key,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      themeMode: ThemeMode.light,
      localizationsDelegates: const [
        AuthModuleLocalizationsDelegate(),
        MenuModuleLocalizationsDelegate(),
        BooksModuleLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'en_US')],
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF242627),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.amber,
          accentColor: const Color(0xFF606060),
        ),
      ),
      builder: (context, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            child ?? Container(),
            StreamBuilder<bool>(
              initialData: false,
              stream: store.loaderStream,
              builder: (_, AsyncSnapshot<bool> snapshot) {
                return (snapshot.data ?? false)
                    ? const FullscreenProgress()
                    : Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
