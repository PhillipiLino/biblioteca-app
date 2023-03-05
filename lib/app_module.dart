import 'package:biblioteca/core/database/books_database.dart';
import 'package:biblioteca/core/utils/routes/app_routes.dart';
import 'package:biblioteca/core/utils/routes/constants.dart';
import 'package:biblioteca/modules/books/data/datasources/books_datasource.dart';
import 'package:biblioteca/modules/books/data/repositories/books_repository_implementation.dart';
import 'package:biblioteca/modules/books/domain/repositories/books_repository.dart';
import 'package:biblioteca/modules/books/domain/usecases/create_book_usecase.dart';
import 'package:biblioteca/modules/books/domain/usecases/delete_book_usecase.dart';
import 'package:biblioteca/modules/books/domain/usecases/get_books_usecase.dart';
import 'package:biblioteca_books_module/biblioteca_books_module.dart';
import 'package:biblioteca_sdk/clients.dart';
import 'package:clean_architecture_utils/events.dart';
import 'package:commons_tools_sdk/error_report.dart';
import 'package:commons_tools_sdk/trackers.dart';
import 'package:firebase_sdk/error_report.dart';
import 'package:firebase_sdk/trackers.dart';
import 'package:floor/floor.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'client/client_interceptor.dart';
import 'core/database/book_dao.dart';
import 'core/utils/helpers/image_helper.dart';
import 'event_controller.dart';
import 'features/presenter/pages/splash_page.dart';
import 'modules/books/data/datasources/database_datasource_implementation.dart';
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
    AsyncBind<IBooksDatasource>(
      (i) async => DatabaseDataSourceImplementation(i<IBooksDao>()),
    ),
    AsyncBind<IBooksRepository>((i) async => BooksRepositoryImplementation(
          i.get(),
          i.get(),
        )),
    AsyncBind<GetBooksUsecase>((i) async => GetBooksUsecase(i.get())),
    AsyncBind<CreateBooksUsecase>((i) async => CreateBooksUsecase(i.get())),
    AsyncBind<DeleteBookUsecase>((i) async => DeleteBookUsecase(i.get())),
    AsyncBind<EventController>((i) async => EventController(
          i.get(),
          i.get(),
          i.get(),
          i.get(),
        )),

    ///
    Bind((i) => ImageHelper()),

    Bind((i) => AppRoutes()),
    Bind.singleton<TrackersHelper>((i) => TrackersHelper(i.get())),
    Bind.singleton<EventBus>((i) => EventBus()),
    Bind.singleton<TrackersManager>((i) => TrackersManager(
          [i.get<FirebaseSDK>()],
        )),
    Bind<IClientInterceptor>((i) => ClientInterceptor()),
    Bind<IErrorReport>((i) => CrashlyticsErrorReport()),
    Bind<FirebaseSDK>((i) => FirebaseSDK()),
    Bind<IClient>((i) {
      return DioClient(
        typesToLog: [],
        interceptor: i.get(),
        errorReport: i.get(),
      );
    }),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const SplashPage(),
      guards: [SplashRouteGuardGuard()],
    ),
    ModuleRoute(
      booksRoute,
      module: BooksModule(),
      guards: [SplashRouteGuardGuard()],
    ),
    ModuleRoute(
      menuRoute,
      module: MenuModule(),
      guards: [SplashRouteGuardGuard()],
    ),
  ];
}

class SplashRouteGuardGuard extends RouteGuard {
  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    await Modular.isModuleReady<AppModule>();
    await Modular.isModuleReady<BooksModule>();
    return true;
  }
}
