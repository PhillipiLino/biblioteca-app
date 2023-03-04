import 'package:biblioteca/core/database/books_database.dart';
import 'package:biblioteca/core/utils/routes/app_routes.dart';
import 'package:biblioteca/core/utils/routes/constants.dart';
import 'package:biblioteca/modules/books/presenter/utils/persist_list_helper.dart';
import 'package:biblioteca_sdk/clients.dart';
import 'package:commons_tools_sdk/error_report.dart';
import 'package:floor/floor.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'client/client_interceptor.dart';
import 'features/presenter/pages/splash_page.dart';
import 'modules/menu/menu_module.dart';
import 'trackers_helper.dart';

class AppModule extends Module {
  static final migration1to2 = Migration(1, 2, (database) async {
    // await database.execute('ALTER TABLE books_table DROP COLUMN updated_at');
    await database.execute('ALTER TABLE books_table ADD COLUMN updated_at INT');
    await database.execute(
        'UPDATE books_table SET updated_at = ${DateTime.now().millisecondsSinceEpoch}');
  });

  @override
  final List<Bind> binds = [
    AsyncBind<BooksDatabase>((i) async => await $FloorBooksDatabase
        .databaseBuilder('books-db.db')
        .addMigrations([migration1to2]).build()),
    AsyncBind((i) async => i<BooksDatabase>().bookDao),
    Bind.singleton<TrackersHelper>((i) => TrackersHelper()),
    Bind((i) => PersistListHelper()),
    Bind((i) => AppRoutes()),
    Bind<IClientInterceptor>((i) => ClientInterceptor()),
    Bind<IErrorReport>((i) => ErrorReport()),
    Bind<IClient>((i) {
      return DioClient(
        typesToLog: [],
        interceptor: i.get(),
        errorReport: i.get(),
        // initialEnvironment: Environment(),
      );
    }),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const SplashPage(),
    ),
    ModuleRoute(menuRoute, module: MenuModule()),
  ];
}
