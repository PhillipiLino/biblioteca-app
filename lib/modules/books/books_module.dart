import 'package:biblioteca/core/database/book_dao.dart';
import 'package:biblioteca/core/utils/helpers/image_helper.dart';
import 'package:biblioteca/modules/books/data/datasources/database_datasource_implementation.dart';
import 'package:biblioteca/modules/books/data/repositories/books_repository_implementation.dart';
import 'package:biblioteca/modules/books/domain/usecases/create_book_usecase.dart';
import 'package:biblioteca/modules/books/domain/usecases/delete_book_usecase.dart';
import 'package:biblioteca/modules/books/presenter/pages/details_page.dart';
import 'package:biblioteca/modules/books/presenter/widgets/books_list/books_list_store.dart';
import 'package:biblioteca/modules/books/domain/usecases/get_books_usecase.dart';
import 'package:biblioteca/modules/books/presenter/controllers/details_store.dart';
import 'package:biblioteca/modules/books/presenter/controllers/home_store.dart';
import 'package:biblioteca/modules/books/presenter/pages/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BooksModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => HomeStore(i(), i())),
    Bind((i) => BooksListStore(i())),
    Bind((i) => DetailsStore(i())),
    Bind((i) => GetBooksUsecase(i())),
    Bind((i) => CreateBooksUsecase(i())),
    Bind((i) => DeleteBookUsecase(i())),
    Bind((i) => BooksRepositoryImplementation(i(), i())),
    Bind((i) => DatabaseDataSourceImplementation(i<IBooksDao>())),
    Bind((i) => ImageHelper()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const HomePage(),
    ),
    ChildRoute(
      '/details/',
      child: (_, args) => DetailsPage(args.data),
      transition: TransitionType.downToUp,
    ),
  ];
}
