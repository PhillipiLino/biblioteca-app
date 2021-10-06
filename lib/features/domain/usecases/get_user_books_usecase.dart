import 'package:clean_biblioteca/core/usecase/errors/failures.dart';
import 'package:clean_biblioteca/core/usecase/usecase.dart';
import 'package:clean_biblioteca/features/domain/entities/book_entity.dart';
import 'package:clean_biblioteca/features/domain/repositories/books_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserBooksUsecase implements Usecase<List<BookEntity>, String> {
  final IBooksRepository repository;

  GetUserBooksUsecase(this.repository);

  @override
  Future<Either<Failure, List<BookEntity>>> call(String params) {
    return repository.getUserBooks(params);
  }
}
