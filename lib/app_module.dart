import 'package:biblioteca/core/database/books_database.dart';
import 'package:biblioteca/core/utils/routes/app_routes.dart';
import 'package:biblioteca/core/utils/routes/constants.dart';
import 'package:biblioteca/modules/books/books_module.dart';
import 'package:biblioteca/modules/books/presenter/utils/persist_list_helper.dart';
import 'package:biblioteca/modules/profile/profile_module.dart';
import 'package:biblioteca/features/presenter/controller/bottom_navigation_store.dart';
import 'package:biblioteca/features/presenter/pages/bottom_navigation_page.dart';
import 'package:biblioteca/modules/search/search_module.dart';
import 'package:floor/floor.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'features/presenter/pages/splash_page.dart';

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
    Bind((i) => BottomNavigationStore(i())),
    Bind((i) => PersistListHelper()),
    Bind((i) => AppRoutes()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const SplashPage(),
    ),
    ChildRoute(
      menuRoute,
      child: (_, args) => BottomNavigationPage(args.data),
      children: [
        ModuleRoute(
          booksRoute,
          module: BooksModule(),
          transition: TransitionType.noTransition,
        ),
        ModuleRoute(
          searchRoute,
          module: SearchModule(),
          transition: TransitionType.noTransition,
        ),
        ModuleRoute(
          profileRoute,
          module: ProfileModule(),
          transition: TransitionType.noTransition,
        ),
      ],
    ),
  ];
}
