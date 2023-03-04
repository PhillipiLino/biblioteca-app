import 'package:biblioteca/core/usecase/errors/failures.dart';
import 'package:biblioteca/core/utils/adapters/book_adapter.dart';
import 'package:biblioteca/core/utils/adapters/dartz_either_adapter.dart';
import 'package:biblioteca/core/utils/debouncer.dart';
import 'package:biblioteca/core/utils/routes/app_routes.dart';
import 'package:biblioteca/modules/search/domain/entities/search_book_entity.dart';
import 'package:biblioteca/modules/search/domain/entities/search_params.dart';
import 'package:biblioteca/modules/search/domain/usecases/search_books_usecase.dart';
import 'package:flutter_triple/flutter_triple.dart';

class SearchStore extends NotifierStore<Failure, List<SearchBookEntity>> {
  final SearchBooksUsecase usecase;
  final AppRoutes _routes;
  final _debouncer = Debouncer(milliseconds: 800);

  SearchStore(
    this.usecase,
    this._routes,
  ) : super([]);

  search(String filter) async {
    _debouncer.run(() {
      if (filter.isEmpty) {
        update([]);
        setLoading(false);
        return;
      }

      final params = SearchParams(filter: filter, page: 0);
      executeEither(() => DartzEitherAdapter.adapter(usecase(params)));
    });
  }

  Future<List<SearchBookEntity>> paginate(String filter, int page) async {
    final params = SearchParams(filter: filter, page: page);
    final result = await usecase(params);
    result.fold((error) => setError(error), (success) => {});

    if (result.isRight()) {
      return result.getOrElse(() => <SearchBookEntity>[]);
    }

    return [];
  }

  openDetails(SearchBookEntity book) => _routes.openDetails(book.toDetails());

  void dispose() {
    _debouncer.dispose();
  }
}
