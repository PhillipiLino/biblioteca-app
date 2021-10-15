import 'package:biblioteca/core/http_client/http_implementation.dart';
import 'package:biblioteca/modules/search/data/datasources/google_datasource_implementation.dart';
import 'package:biblioteca/modules/search/data/repositories/search_books_repository_implementation.dart';
import 'package:biblioteca/modules/search/domain/usecases/search_books_usecase.dart';
import 'package:biblioteca/modules/search/presenter/controller/search_store.dart';
import 'package:biblioteca/modules/search/presenter/pages/search_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;

class SearchModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => SearchStore(i(), i())),
    Bind((i) => SearchBooksUsecase(i())),
    Bind((i) => SearchBooksRepositoryImplementation(i())),
    Bind((i) => GoogleDataSourceImplementation(i())),
    Bind.lazySingleton((i) => HttpImplementation(i.get())),
    Bind.lazySingleton((i) => http.Client()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const SearchPage(),
    ),
  ];
}
