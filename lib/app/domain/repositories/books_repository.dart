import 'package:biblioteca_books_module/biblioteca_books_module.dart';
import 'package:clean_architecture_utils/failures.dart';
import 'package:dartz/dartz.dart';

import '../../../modules/profile/domain/entities/user_progress_entity.dart';

abstract class IBooksRepository {
  Future<Either<Failure, List<BookEntity>>> getBooks();
  Future<Either<Failure, bool>> createBook(BookToSaveEntity infoToSave);
  Future<Either<Failure, bool>> deleteBook(BookEntity book);
  Future<Either<Failure, bool>> updateBooks(List<BookEntity> infoToSave);
  Future<Either<Failure, List<UserProgressEntity>>> getProgress();
}
