import 'package:clean_biblioteca/core/usecase/errors/exceptions.dart';
import 'package:clean_biblioteca/features/data/datasources/books_datasource.dart';
import 'package:clean_biblioteca/features/domain/entities/book_entity.dart';
import 'package:clean_biblioteca/core/usecase/errors/failures.dart';
import 'package:clean_biblioteca/features/domain/repositories/books_repository.dart';
import 'package:dartz/dartz.dart';

class BooksRepositoryImplementation implements IBooksRepository {
  final IBooksDatasource datasource;

  BooksRepositoryImplementation(this.datasource);

  @override
  Future<Either<Failure, List<BookEntity>>> getUserBooks(String userId) async {
    try {
      final result = await datasource.getBooksFromUser(userId);
      return Right(result);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> createBook(BookEntity book) async {
    try {
      await datasource.createBook(book.toModel());
      return const Right(true);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }
}
