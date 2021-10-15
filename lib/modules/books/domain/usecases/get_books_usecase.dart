import 'package:biblioteca/core/usecase/errors/failures.dart';
import 'package:biblioteca/core/usecase/usecase.dart';
import 'package:biblioteca/modules/books/domain/entities/book_entity.dart';
import 'package:biblioteca/modules/books/domain/repositories/books_repository.dart';
import 'package:dartz/dartz.dart';

class GetBooksUsecase implements Usecase<List<BookEntity>, NoParams> {
  final IBooksRepository repository;

  GetBooksUsecase(this.repository);

  @override
  Future<Either<Failure, List<BookEntity>>> call(NoParams params) {
    return repository.getBooks();
  }
}
