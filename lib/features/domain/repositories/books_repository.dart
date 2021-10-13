import 'package:clean_biblioteca/core/usecase/errors/failures.dart';
import 'package:clean_biblioteca/features/domain/entities/book_entity.dart';
import 'package:clean_biblioteca/features/domain/entities/book_to_save_entity.dart';
import 'package:clean_biblioteca/features/domain/entities/user_progress_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IBooksRepository {
  Future<Either<Failure, List<BookEntity>>> getUserBooks(String userId);
  Future<Either<Failure, bool>> createBook(BookToSaveEntity infoToSave);
  Future<Either<Failure, bool>> deleteBook(BookEntity book);
  Future<Either<Failure, List<UserProgressEntity>>> getProgress();
}
