import 'package:biblioteca/core/utils/routes/app_routes.dart';
import 'package:biblioteca/modules/books/domain/entities/book_entity.dart';
import 'package:biblioteca/modules/books/domain/usecases/get_books_usecase.dart';
import 'package:biblioteca/modules/books/presenter/utils/persist_list_helper.dart';
import 'package:clean_architecture_utils/events.dart';
import 'package:clean_architecture_utils/usecase.dart';
import 'package:clean_architecture_utils/utils.dart';

class HomeStore extends MainStore<List<BookEntity>> {
  final GetBooksUsecase usecase;
  final PersistListHelper persistList;
  final AppRoutes _routes;

  HomeStore(
    this.usecase,
    this.persistList,
    this._routes,
    EventBus? eventBus,
  ) : super(eventBus, persistList.list);

  getBooks() async {
    executeEither(() => DartzEitherAdapter.adapter(usecase(NoParams())));
  }

  setPersistentList(List<BookEntity> list) {
    persistList.list = list;
  }

  openDetails([BookEntity? book]) => _routes.openDetails(book);
}
