import 'package:clean_biblioteca/core/database/book_dao.dart';
import 'package:clean_biblioteca/core/database/books_database.dart';
import 'package:clean_biblioteca/features/data/datasources/database_datasource_implementation.dart';
import 'package:clean_biblioteca/features/data/repositories/books_repository_implementation.dart';
import 'package:clean_biblioteca/features/domain/usecases/create_book_usecase.dart';
import 'package:clean_biblioteca/features/domain/usecases/get_user_books_usecase.dart';
import 'package:clean_biblioteca/features/presenter/controller/details_store.dart';
import 'package:clean_biblioteca/features/presenter/controller/home_store.dart';
import 'package:clean_biblioteca/features/presenter/pages/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'features/presenter/pages/details_page.dart';
import 'features/presenter/pages/splash_page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    AsyncBind<BooksDatabase>((i) async =>
        await $FloorBooksDatabase.databaseBuilder('books-db.db').build()),
    AsyncBind((i) async => i<BooksDatabase>().bookDao),
    Bind((i) => HomeStore(i())),
    Bind((i) => DetailsStore(i())),
    Bind((i) => GetUserBooksUsecase(i())),
    Bind((i) => CreateBooksUsecase(i())),
    Bind((i) => BooksRepositoryImplementation(i())),
    Bind((i) => DatabaseDataSourceImplementation(i<IBooksDao>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (context, args) => const SplashPage()),
    ChildRoute('/home/', child: (_, __) => const HomePage()),
    ChildRoute('/book/', child: (_, args) => DetailPage(args.data)),
  ];
}
