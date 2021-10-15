import 'package:biblioteca/core/usecase/errors/failures.dart';
import 'package:biblioteca/core/usecase/usecase.dart';
import 'package:biblioteca/core/utils/adapters/dartz_either_adapter.dart';
import 'package:biblioteca/core/utils/routes/app_routes.dart';
import 'package:biblioteca/modules/books/domain/entities/book_entity.dart';
import 'package:biblioteca/modules/books/domain/usecases/get_books_usecase.dart';
import 'package:biblioteca/modules/books/presenter/utils/persist_list_helper.dart';
import 'package:flutter_triple/flutter_triple.dart';

class HomeStore extends NotifierStore<Failure, List<BookEntity>> {
  final GetBooksUsecase usecase;
  final PersistListHelper persistList;
  final AppRoutes _routes;

  HomeStore(
    this.usecase,
    this.persistList,
    this._routes,
  ) : super(persistList.list);

  getBooks() async {
    executeEither(() => DartzEitherAdapter.adapter(usecase(NoParams())));
  }

  setPersistentList(List<BookEntity> list) {
    persistList.list = list;
  }

  openDetails([BookEntity? book]) => _routes.openDetails(book);
}