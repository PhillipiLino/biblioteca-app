import 'package:biblioteca/core/usecase/errors/failures.dart';
import 'package:biblioteca/modules/books/domain/entities/book_entity.dart';
import 'package:biblioteca/modules/books/domain/entities/book_to_save_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IBooksRepository {
  Future<Either<Failure, List<BookEntity>>> getBooks();
  Future<Either<Failure, bool>> createBook(BookToSaveEntity infoToSave);
  Future<Either<Failure, bool>> deleteBook(BookEntity book);
}
