import 'package:biblioteca/core/database/book_dao.dart';
import 'package:biblioteca/core/database/books_database.dart';
import 'package:biblioteca/core/http_client/http_implementation.dart';
import 'package:biblioteca/core/utils/helpers/image_helper.dart';
import 'package:biblioteca/features/data/datasources/database_datasource_implementation.dart';
import 'package:biblioteca/features/data/repositories/books_repository_implementation.dart';
import 'package:biblioteca/features/domain/usecases/create_book_usecase.dart';
import 'package:biblioteca/features/domain/usecases/delete_book_usecase.dart';
import 'package:biblioteca/features/domain/usecases/get_progress_usecase.dart';
import 'package:biblioteca/features/domain/usecases/get_user_books_usecase.dart';
import 'package:biblioteca/features/domain/usecases/search_books_usecase.dart';
import 'package:biblioteca/features/presenter/controller/bottom_navigation_store.dart';
import 'package:biblioteca/features/presenter/controller/details_store.dart';
import 'package:biblioteca/features/presenter/controller/home_store.dart';
import 'package:biblioteca/features/presenter/controller/progress_store.dart';
import 'package:biblioteca/features/presenter/controller/search_store.dart';
import 'package:biblioteca/features/presenter/pages/bottom_navigation_page.dart';
import 'package:biblioteca/features/presenter/pages/home_page.dart';
import 'package:biblioteca/features/presenter/pages/progress_page.dart';
import 'package:biblioteca/features/presenter/pages/search_page.dart';
import 'package:biblioteca/features/presenter/widgets/books_list/books_list_store.dart';
import 'package:floor/floor.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'features/presenter/pages/details_page.dart';
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
    Bind((i) => HomeStore(i(), i())),
    Bind((i) => PersistList()),
    Bind((i) => BooksListStore(i())),
    Bind((i) => DetailsStore(i())),
    Bind((i) => ProgressStore(i())),
    Bind((i) => SearchStore(i())),
    Bind((i) => BottomNavigationStore()),
    Bind((i) => GetUserBooksUsecase(i())),
    Bind((i) => CreateBooksUsecase(i())),
    Bind((i) => DeleteBookUsecase(i())),
    Bind((i) => GetProgressUsecase(i())),
    Bind((i) => SearchBooksUsecase(i())),
    Bind((i) => BooksRepositoryImplementation(i(), i())),
    Bind((i) => DatabaseDataSourceImplementation(i<IBooksDao>(), i())),
    Bind((i) => ImageHelper()),
    Bind.lazySingleton((i) => HttpImplementation(i.get())),
    Bind.lazySingleton((i) => http.Client()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (context, args) => const SplashPage()),
    ChildRoute(
      '/menu/',
      child: (_, args) => BottomNavigationPage(args.data),
      children: [
        ChildRoute(
          '/home/',
          child: (_, args) => const HomePage(),
          transition: TransitionType.noTransition,
        ),
        ChildRoute(
          '/progress/',
          child: (_, args) => const ProgressPage(),
          transition: TransitionType.noTransition,
        ),
        ChildRoute(
          '/search/',
          child: (_, args) => const SearchPage(),
          transition: TransitionType.noTransition,
        ),
      ],
    ),
    ChildRoute(
      '/book/',
      child: (_, args) => DetailsPage(args.data),
      transition: TransitionType.downToUp,
    ),
  ];
}
