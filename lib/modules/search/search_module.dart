import 'package:biblioteca/modules/search/data/repositories/search_books_repository_implementation.dart';
import 'package:biblioteca/modules/search/domain/usecases/search_books_usecase.dart';
import 'package:biblioteca/modules/search/presenter/pages/search_page.dart';
import 'package:biblioteca/modules/search/presenter/store/search_store.dart';
import 'package:biblioteca_network_sdk/google_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((inject) => GoogleService(inject.get())),
    Bind((inject) => SearchStore(inject.get(), inject.get())),
    Bind((inject) => SearchBooksUsecase(inject.get())),
    Bind((inject) => SearchBooksRepositoryImplementation(inject.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const SearchPage(),
    ),
  ];
}
