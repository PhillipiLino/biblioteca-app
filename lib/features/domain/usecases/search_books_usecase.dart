import 'package:biblioteca/core/usecase/errors/failures.dart';
import 'package:biblioteca/core/usecase/usecase.dart';
import 'package:biblioteca/features/domain/entities/book_entity.dart';
import 'package:biblioteca/features/domain/repositories/books_repository.dart';
import 'package:dartz/dartz.dart';

class SearchBooksUsecase implements Usecase<List<BookEntity>, SearchParams> {
  final IBooksRepository repository;

  SearchBooksUsecase(this.repository);

  @override
  Future<Either<Failure, List<BookEntity>>> call(SearchParams params) {
    return repository.searchBooks(params);
  }
}

class SearchParams {
  final String filter;
  final int page;

  SearchParams(this.filter, this.page);
}
