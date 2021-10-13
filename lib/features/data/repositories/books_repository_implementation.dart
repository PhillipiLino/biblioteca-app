import 'package:clean_biblioteca/core/usecase/errors/exceptions.dart';
import 'package:clean_biblioteca/core/utils/helpers/image_helper.dart';
import 'package:clean_biblioteca/features/data/datasources/books_datasource.dart';
import 'package:clean_biblioteca/features/domain/entities/book_entity.dart';
import 'package:clean_biblioteca/core/usecase/errors/failures.dart';
import 'package:clean_biblioteca/features/domain/entities/book_to_save_entity.dart';
import 'package:clean_biblioteca/features/domain/entities/user_progress_entity.dart';
import 'package:clean_biblioteca/features/domain/repositories/books_repository.dart';
import 'package:dartz/dartz.dart';

class BooksRepositoryImplementation implements IBooksRepository {
  final IBooksDatasource datasource;
  final ImageHelper imageHelper;

  BooksRepositoryImplementation(this.datasource, this.imageHelper);

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
  Future<Either<Failure, bool>> createBook(BookToSaveEntity infoToSave) async {
    try {
      await datasource.createBook(infoToSave.book.toModel());
      if (infoToSave.imageFile != null) {
        await imageHelper.saveImage(
            infoToSave.imageFile!, infoToSave.book.imagePath ?? '');
      }

      return const Right(true);
    } on DatabaseException {
      return Left(DatabaseFailure());
    } on ImageException {
      return Left(SaveImageFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteBook(BookEntity book) async {
    try {
      await datasource.deleteBook(book.toModel());
      return const Right(true);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<UserProgressEntity>>> getProgress() async {
    try {
      final result = await datasource.getProgress() ?? [];
      return Right(result);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }
}
