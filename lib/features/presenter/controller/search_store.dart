import 'package:biblioteca/core/usecase/errors/failures.dart';
import 'package:biblioteca/core/utils/adapters/dartz_either_adapter.dart';
import 'package:biblioteca/core/utils/debouncer.dart';
import 'package:biblioteca/features/domain/entities/book_entity.dart';
import 'package:biblioteca/features/domain/usecases/search_books_usecase.dart';
import 'package:flutter_triple/flutter_triple.dart';

class SearchStore extends NotifierStore<Failure, List<BookEntity>> {
  final SearchBooksUsecase usecase;
  final _debouncer = Debouncer(milliseconds: 800);

  SearchStore(this.usecase) : super([]);

  search(String filter) async {
    _debouncer.run(() {
      if (filter.isEmpty) {
        update([]);
        setLoading(false);
        return;
      }

      executeEither(() => DartzEitherAdapter.adapter(usecase(filter)));
    });
  }

  void dispose() {
    _debouncer.dispose();
  }
}
