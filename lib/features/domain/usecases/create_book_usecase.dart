import 'package:clean_biblioteca/core/usecase/errors/failures.dart';
import 'package:clean_biblioteca/core/usecase/usecase.dart';
import 'package:clean_biblioteca/features/domain/entities/book_entity.dart';
import 'package:clean_biblioteca/features/domain/repositories/books_repository.dart';
import 'package:dartz/dartz.dart';

class CreateBooksUsecase implements Usecase<bool, BookEntity> {
  final IBooksRepository repository;

  CreateBooksUsecase(this.repository);

  @override
  Future<Either<Failure, bool>> call(BookEntity params) {
    return repository.createBook(params);
  }
}
