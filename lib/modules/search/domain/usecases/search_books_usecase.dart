import 'package:biblioteca/core/usecase/errors/failures.dart';
import 'package:biblioteca/core/usecase/usecase.dart';
import 'package:biblioteca/modules/search/domain/entities/search_book_entity.dart';
import 'package:biblioteca/modules/search/domain/entities/search_params.dart';
import 'package:biblioteca/modules/search/domain/repositories/books_repository.dart';
import 'package:dartz/dartz.dart';

class SearchBooksUsecase
    implements Usecase<List<SearchBookEntity>, SearchParams> {
  final ISearchRepository repository;

  SearchBooksUsecase(this.repository);

  @override
  Future<Either<Failure, List<SearchBookEntity>>> call(SearchParams params) {
    return repository.searchBooks(params);
  }
}
