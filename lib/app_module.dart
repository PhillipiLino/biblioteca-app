import 'dart:developer';

import 'package:biblioteca/auth_store.dart';
import 'package:biblioteca/core/database/books_database.dart';
import 'package:biblioteca/core/utils/routes/app_routes.dart';
import 'package:biblioteca/core/utils/routes/constants.dart';
import 'package:biblioteca/features/stores/splash_page_store.dart';
import 'package:biblioteca/modules/books/data/datasources/books_datasource.dart';
import 'package:biblioteca/modules/books/data/repositories/books_repository_implementation.dart';
import 'package:biblioteca/modules/books/domain/repositories/books_repository.dart';
import 'package:biblioteca/modules/books/domain/usecases/create_book_usecase.dart';
import 'package:biblioteca/modules/books/domain/usecases/delete_book_usecase.dart';
import 'package:biblioteca/modules/books/domain/usecases/get_books_usecase.dart';
import 'package:biblioteca/modules/menu/presenter/utils/bottom_navigation_item.dart';
import 'package:biblioteca/preferences_manager.dart';
import 'package:biblioteca_auth_module/biblioteca_auth_module.dart';
import 'package:biblioteca_books_module/biblioteca_books_module.dart';
import 'package:biblioteca_sdk/clients.dart';
import 'package:clean_architecture_utils/events.dart';
import 'package:commons_tools_sdk/commons_tools_sdk.dart';
import 'package:commons_tools_sdk/error_report.dart';
import 'package:commons_tools_sdk/preferences.dart';
import 'package:commons_tools_sdk/trackers.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

class UserAuth extends Equatable {
  final String uid;
  final String name;
  final String email;

  static const String _uid = 'uid';
  static const String _name = 'name';
  static const String _email = 'email';

  const UserAuth({
    required this.uid,
    required this.name,
    required this.email,
  });

  UserAuth.fromJson(Map<String, dynamic> json)
      : uid = castOrNull(json[_uid]),
        name = castOrNull(json[_name]),
        email = castOrNull(json[_email]);

  Map<String, dynamic> toJson() => {
        _uid: uid,
        _name: name,
        _email: email,
      };

  @override
  List<Object?> get props => [
        uid,
        name,
        email,
      ];
}

class LoginCallback extends ILoginCallback {
  final AuthStore authStore;
  final AppRoutes routes;

  LoginCallback(this.authStore, this.routes);

  @override
  onLoginFailure(Object? error, StackTrace stack) {}

  @override
  onLoginSuccess(UserAuthInfo info) async {
    final credential = GoogleAuthProvider.credential(
      accessToken: info.accessToken,
      idToken: info.idToken,
    );

    FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
      final name = value.user?.displayName ?? '';
      final uid = value.user?.uid ?? '';
      final email = value.user?.email ?? '';

      final user = UserAuth(uid: uid, name: name, email: email);
      await authStore.setUser(user);
      routes.goToMenu(BottomNavigationItem.books, null);
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }
}

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
    Bind((i) => SharedPreferencesAdapter()),
    Bind((i) => PreferencesManager(i.get())),
    Bind((i) => AuthStore(i.get(), i.get())),
    Bind((i) => SplashPageStore(i.get(), i.get())),
    Bind((i) => ImageHelper()),
    Bind((i) => LoginCallback(i.get(), i.get())),
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
      '/login',
      module: AuthModule(),
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
